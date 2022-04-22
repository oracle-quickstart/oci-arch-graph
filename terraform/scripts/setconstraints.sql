alter table bank_accounts add primary key (acct_id);

alter table bank_txns add txn_id number;
update bank_txns set txn_id = rownum;
commit;

alter table bank_txns add primary key (txn_id);
alter table bank_txns modify from_acct_id references bank_accounts (acct_id);
alter table bank_txns modify to_acct_id references bank_accounts (acct_id);
