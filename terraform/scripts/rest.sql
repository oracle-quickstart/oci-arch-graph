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
