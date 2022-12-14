# How to build an S3 hosted site.

This package will create the following: 
- S3 bucket for hosting html pages on. (s3.tf)
- Route53 zones for owned domains (optional, uncomment the file route_53.tf)
- Cloudfront configuration to create a cloudfront distribution for the s3 bucket (optional, uncomment the file cloudfront.tf)
- Monitoring/Alarms (monitoring.tf, uncomment the file but also depends on cloudfront.tf)
- Pulls index.html from a specified repo and branch so that you can change branches depending on the environment.

Update the values in terraform.tfvars as appropriate.

Uncomment any files to build more infrastructure as appropriate. 

Run terraform apply once to create an empty bucket with the correct config and to pull down the website code. 

Run terraform apply once more to upload the website to the S3 bucket.

# Statefile

Currently the state file is local. To use a statefile in S3 ensure a seperate S3 bucket is created and update statefile.tf.

# To improve

- Move the uploading of S3 from TF to Github actions. 
- Turn all of this into a module so it can be easily applied to different environments.
- Improve the mechanism for optional infrastructure deployment 

# Viewing the site.

You can view the site as hosted in [S3 here](http://lukas-ball-s3-example-website.s3-website.eu-west-2.amazonaws.com/). Which is taken from the terraform output  when `tf apply` is run.