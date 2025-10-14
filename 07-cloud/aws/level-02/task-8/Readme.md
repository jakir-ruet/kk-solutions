### Create a New Private S3 Bucket

```bash
aws s3api create-bucket --bucket devops-sync-27558 --region us-east-1
aws s3api put-bucket-acl --bucket devops-sync-27558 --acl private
```

### Proceed with data migration

```bash
aws s3 sync s3://devops-s3-13653 s3://devops-sync-27558
```

### Check Bucket Public Access Settings (recommended)

```bash
aws s3api get-public-access-block --bucket devops-sync-27558
```

### Check

```bash
aws s3 ls s3://devops-s3-13653
aws s3 ls s3://devops-sync-27558
```
