<bean
        id="${OBJECT_NAME}Dao"
        class="${PACKAGE_DAO}.${CLASS_MODEL}Dao">
        <constructor-arg ref="dataSource"/>
    </bean>