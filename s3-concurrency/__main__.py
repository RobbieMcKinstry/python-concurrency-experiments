"""An AWS Python Pulumi program"""
import pulumi
import pulumi_aws as aws
import os
from math import floor

TOTAL_RESOURCES = int(os.getenv("RESOURCE_COUNT"))
COUNT_PER_RESOURCE = floor(TOTAL_RESOURCES / 2)

# SQS
for i in range(COUNT_PER_RESOURCE):
    name = f'pulumi-{str(i).rjust(5,"0")}'
    aws.sqs.Queue(
        name,
        tags={
            'owner': 'robbie-mckinstry',
            'anyone-can-delete-me': 'true',
            'python-concurrency-experiment': 'true',
        }
    )
    
# SNS
for i in range(COUNT_PER_RESOURCE):
    name = f'pulumi-{str(i).rjust(5,"0")}'
    aws.sns.Topic(
        name,
        tags={
            'owner': 'robbie-mckinstry',
            'anyone-can-delete-me': 'true',
            'python-concurrency-experiment': 'true',
        }
    )