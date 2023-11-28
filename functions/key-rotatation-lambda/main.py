import os
from datetime import date
from email.mime.multipart import MIMEMultipart
from email.mime.text import MIMEText
import boto3

# creating boto3 clients for AWS IAM and SES
ses = boto3.client("ses")
iam = boto3.client("iam")

# Setting up variables
EXPIRY = int(os.getenv("SET_EXPIRY"))
EXPIRY_DAY_LIMIT = int(EXPIRY - 10)
KEY_USER = os.getenv("KEY_USER_NAME")
TO_EMAILS = ["to_email_address"]
FROM_EMAIL = "FROM_EMAIL_ADDRESS"

# Function to get key details
def get_key_details(username=KEY_USER):
    response = iam.list_access_keys(UserName=username)
    access_keys = response.get("AccessKeyMetadata", [])
    for access in access_keys:
        access["active_days"] = (date.today() - access["CreateDate"].date()).days
    return access_keys

# Function to send email
def send_email(subject, body, to_emails):
    msg = MIMEMultipart()
    msg["Subject"] = subject
    msg["From"] = FROM_EMAIL
    msg["To"] = ", ".join(to_emails)
    body_part = MIMEText(body, "plain")
    msg.attach(body_part)

    response = ses.send_raw_email(
        Source=msg["From"],
        Destinations=to_emails,
        RawMessage={"Data": msg.as_string()},
    )
    print(f"Email sent via AWS SES! Message ID: {response['MessageId']}")


# Handler function for Lambda
def handler(event, context):
    keys = get_key_details()
    expired_keys = [k for k in keys if k["active_days"] > EXPIRY_DAY_LIMIT]

    email_body = f''' Hi All,
    {''.join([f"""
        Access key for Okta user - {key['UserName']} is expiring in {EXPIRY - key['active_days'] } days.
        Please rotate key before it expires.
        """ for key in expired_keys])}
    {'Please remove all expired keys, only keep one active key' if len(expired_keys) > 1 else ''}

    Regards,
    Akhilesh Mishra
        '''
    if expired_keys:
        send_email(
            subject="Key Rotation Reminder Email",
            body=email_body,
            to_emails=TO_EMAILS,
        )

if __name__ == "__main__":
    handler({}, {})
