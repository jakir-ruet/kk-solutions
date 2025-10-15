### Check for the RDS Instance to be Available

```bash
aws rds describe-db-instances --query 'DBInstances[?DBInstanceStatus==`available`].[DBInstanceIdentifier,DBInstanceStatus]' --output table
```

### Create Snapshot

```bash
aws rds create-db-snapshot \
  --db-snapshot-identifier nautilus-snapshot \
  --db-instance-identifier nautilus-rds
```

### Wait until the snapshot is available

```bash
aws rds describe-db-snapshots --snapshot-type manual --query 'DBSnapshots[?Status==`available`].[DBSnapshotIdentifier,DBInstanceIdentifier,Status]' --output table
```

### Restore Snapshot

```bash
aws rds restore-db-instance-from-db-snapshot \
  --db-instance-identifier nautilus-snapshot-restore \
  --db-snapshot-identifier nautilus-snapshot \
  --db-instance-class db.t3.micro
```

### Check for the Restored Instance to Be Ready

```bash
aws rds describe-db-instances --query 'DBInstances[?DBInstanceStatus==`available`].[DBInstanceIdentifier,DBInstanceStatus]' --output table
```
