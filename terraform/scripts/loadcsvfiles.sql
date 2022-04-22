
drop table BANK_ACCOUNTS;
load bank_accounts ./scripts/bank_accounts.csv new;

drop table bank_txns;
load bank_txns ./scripts/bank_txns.csv new;

@./scripts/setconstraints.sql


-- exit
