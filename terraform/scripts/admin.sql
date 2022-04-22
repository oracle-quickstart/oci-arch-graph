create user graphuser identified by 
	"&1" quota unlimited on data;
grant connect, resource to graphuser;
grant graph_developer to graphuser;
ALTER USER graphuser GRANT CONNECT THROUGH "GRAPH$PROXY_USER";
-- "wid#770GSdemo1"
