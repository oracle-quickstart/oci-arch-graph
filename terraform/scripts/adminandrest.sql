create user graphuser identified by 
	"&1" quota unlimited on data;
grant connect, resource to graphuser;
grant graph_developer to graphuser;
ALTER USER graphuser GRANT CONNECT THROUGH "GRAPH$PROXY_USER";
-- "wid#770GSdemo1"

BEGIN
    ORDS.enable_schema(
    p_enabled             => TRUE,
    p_schema              => 'graphuser',
    p_url_mapping_type    => 'BASE_PATH',
    p_url_mapping_pattern => 'graphuser',
    p_auto_rest_auth      => TRUE
    );

    COMMIT;
END;
