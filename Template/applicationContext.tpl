<beans xmlns="http://www.springframework.org/schema/beans" 
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
    xmlns:jaxws="http://cxf.apache.org/jaxws"
    xmlns:jaxrs="http://cxf.apache.org/jaxrs"
    xmlns:context="http://www.springframework.org/schema/context" 
    default-autowire="byName"
    default-lazy-init="false"
    xmlns:util="http://www.springframework.org/schema/util"
    xsi:schemaLocation="http://www.springframework.org/schema/beans     http://www.springframework.org/schema/beans/spring-beans-3.0.xsd
                http://www.springframework.org/schema/util              http://www.springframework.org/schema/util/spring-util-3.0.xsd
                http://cxf.apache.org/jaxws                             http://cxf.apache.org/schemas/jaxws.xsd
                http://cxf.apache.org/jaxrs                             http://cxf.apache.org/schemas/jaxrs.xsd
                http://www.springframework.org/schema/context           http://www.springframework.org/schema/context/spring-context-3.0.xsd">

    <import resource="classpath:META-INF/cxf/cxf.xml"></import>
    <import resource="classpath:META-INF/cxf/cxf-extension-*.xml"></import>
    <import resource="classpath:META-INF/cxf/cxf-servlet.xml"></import>

    <bean
        id="dataSource"
        class="org.apache.commons.dbcp.BasicDataSource"
        destroy-method="close" >

        <property
            name="driverClassName"
            value="com.mysql.jdbc.Driver" />

        <property
            name="url"
            value="jdbc:mysql://localhost:3306/NOME_BANCO_DADOS" />

        <property
            name="username"
            value="MEU USUARIO" />

        <property
            name="password"
            value="MINHA SENHA" />
    </bean>

    ${BEANS_DEF}</beans>
