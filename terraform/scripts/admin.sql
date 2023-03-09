create user graphuser identified by 
	"&1" quota unlimited on data;
grant connect, resource to graphuser;
grant graph_developer, console_developer to graphuser;
ALTER USER graphuser GRANT CONNECT THROUGH "GRAPH$PROXY_USER";
-- "wid#770GSdemo1"

-- workshop.write('begin 
--                     ords_admin.enable_schema (
--                         p_enabled               => TRUE,
--                         p_schema                => ''' || user_name || ''',
--                         p_url_mapping_type      => ''BASE_PATH'',
--                         p_auto_rest_auth        => TRUE   
--                     );
--                     end;
--                     /');