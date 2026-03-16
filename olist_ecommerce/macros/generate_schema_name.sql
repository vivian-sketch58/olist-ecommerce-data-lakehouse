{% macro generate_schema_name(custom_schema_name, node) -%}
    {%- set default_schema = target.schema -%}
    
    {# If the folder has a custom schema like 'stg' or 'marts', use it #}
    {%- if custom_schema_name is not none -%}
        
        {# SPECIAL LOGIC: If the schema is 'star', don't append it, use the default #}
        {%- if custom_schema_name == 'star' -%}
            {{ default_schema }}
        {%- else -%}
            {{ default_schema }}_{{ custom_schema_name | trim }}
        {%- endif -%}

    {%- else -%}
        {{ default_schema }}
    {%- endif -%}
{%- endmacro %}