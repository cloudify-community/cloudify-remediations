# Cloudify Remediations

This repository contains a set of blueprints that take care of some predefined violations and perform corrective measure.

## Overview

This repository consists of:

* Some terraform modules -Used by terraform plugin to import existing resources-.
* Blueprints that leverage the terraform modules and other plugins to do specific corrective actions.

## attach_instance_policy

This blueprint is used to attach instance policy to EC-2 instance.

## change_instance_state

These blueprints are used to turn-on/off EC-2 instance / Azure VM.

## change_instance_type

These blueprints are used to Change EC-2 instance / Azure VM [type,size].

## enable_monitoring

These blueprints are used to enable enhanced-monitoring on EC-2 instance , enable AzureVM Insights on Azure VM.

## iam_user_handling

These blueprints are used to either disable login profile / attach predefined policy to AWS IAM user.

## s3_buckets_handling

These blueprints are used to either turn on server encryption / add predefined policy to AWS S3 Bucket.
