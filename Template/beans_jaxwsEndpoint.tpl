
    <jaxws:endpoint
        id="${CLASS_MODEL}ServiceWS"
        implementorClass="${PACKAGE_SERVICE_WS}.${CLASS_MODEL}ServiceWS"
        implementor="#${OBJECT_NAME}ServiceWS"
        address="/${CLASS_MODEL}ServiceWS">
    </jaxws:endpoint>

    <jaxrs:server id="${CLASS_MODEL}ServiceRS" address="/${CLASS_MODEL}ServiceRS">
        <jaxrs:serviceBeans>
            <ref bean="${OBJECT_NAME}ServiceRS"/>
        </jaxrs:serviceBeans>
        <jaxrs:extensionMappings>
            <entry key="xml" value="application/xml" />
            <entry key="json" value="application/json" />
        </jaxrs:extensionMappings>
    </jaxrs:server>