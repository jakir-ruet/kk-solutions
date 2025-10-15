### Make Publicly Accessible

```bash
aws rds modify-db-instance \
    --db-instance-identifier datacenter-rds \
    --publicly-accessible \
    --apply-immediately
```

### Check the end point

```bash
aws rds describe-db-instances --db-instance-identifier datacenter-rds \
  --query "DBInstances[*].{DBInstanceIdentifier:DBInstanceIdentifier,PubliclyAccessible:PubliclyAccessible,Endpoint:Endpoint.Address,Port:Endpoint.Port}" \
  --output table
```

### Should show

```bash
PubliclyAccessible > True & Port = 3306
```
