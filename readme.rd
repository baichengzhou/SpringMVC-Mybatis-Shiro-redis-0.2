本项目详细介绍请看：http://www.sojson.com/shiro （强烈推荐）

Demo已经部署到线上，地址是http://shiro.itboy.net，
管理员帐号：admin，密码：sojson.com 如果密码错误，请用sojson。
PS：你可以注册自己的帐号，然后用管理员赋权限给你自己的帐号，但是，每20分钟会把数据初始化一次。建议自己下载源码，让Demo跑起来，然后跑的更快，有问题加群解决。

声明：
本人提供这个Shiro + SpringMvc + Mybatis + Redis 的Demo 本着学习的态度，如果有欠缺和不足的地方，给予指正，并且多多包涵。
“去其糟粕取其精华”。如果觉得写的好的地方就给个赞，写的不好的地方，也请多多包涵。

使用过程：

1.创建数据库。
创建语句		   ：tables.sql

2.插入初始化数据
插入初始化数据：init.data.sql


3.运行。


管理员帐号：admin
密码：sojson
ps:定时任务的sql会把密码改变为sojson.com 


新版本说明：http://www.sojson.com/blog/164.html 和 http://www.sojson.com/blog/165.html


主要解决是之前说的问题：Shiro 教程，关于最近反应的相关异常问题，解决方法合集。

项目在本页面的附件中提取。

一、Cache配置修改。

配置文件（spring-cache.xml ）中已经修改为如下配置：

    <!-- redis 配置,也可以把配置挪到properties配置文件中,再读取 -->
    <bean id="jedisPool" class="redis.clients.jedis.JedisPool">
    	<constructor-arg index="0" ref="jedisPoolConfig" />
        <constructor-arg index="2" value="6379"  name="port" type="int"/>
        <constructor-arg index="3" value="5000"  name="timeout" type="int"/>
        <constructor-arg index="1" value="127.0.0.1" name="host" type="java.lang.String"/>
    </bean>
    <!-- 
    	这种 arguments 构造的方式，之前配置有缺点。
    	这里之前的配置有问题，因为参数类型不一致，有时候jar和环境的问题，导致参数根据index对应，会处理问题，
    	理论上加另一个 name，就可以解决，现在把name 和type都加上，更保险。
     -->

二、登录获取上一个URL地址报错。

当没有获取到退出前的request ，为null 的时候会报错。在（UserLoginController.java  ）135行处有所修改。

    /**
     * shiro 获取登录之前的地址
     * 之前0.1版本这个没判断空。
     */
    SavedRequest savedRequest = WebUtils.getSavedRequest(request);
    String url = null ;
    if(null != savedRequest){
    	url = savedRequest.getRequestUrl();
    }
    /**
     * 我们平常用的获取上一个请求的方式，在Session不一致的情况下是获取不到的
     * String url = (String) request.getAttribute(WebUtils.FORWARD_REQUEST_URI_ATTRIBUTE);
     */

三、删除了配置文件中的cookie写入域的问题。

在配置文件里（spring-shiro.xml ）中的配置有所修改。

    <!-- 会话Cookie模板 -->
    <bean id="sessionIdCookie" class="org.apache.shiro.web.servlet.SimpleCookie">
    	<!--cookie的name，我故意取名叫xxxxbaidu -->
        <constructor-arg value="v_v-s-baidu"/>
        <property name="httpOnly" value="true"/>
        <!--cookie的有效时间 -->
        <property name="maxAge" value="-1"/>
        <!-- 配置存储Session Cookie的domain为 一级域名
        <property name="domain" value=".itboy.net"/>
         -->
    </bean>

上面配置是去掉了 Session  的存储Key 的作用域，之前设置的.itboy.net  ，是写到当前域名的 一级域名  下，这样就可以做到N 个 二级域名  下，三级、四级....下 Session  都是共享的。

    <!-- 用户信息记住我功能的相关配置 -->
    <bean id="rememberMeCookie" class="org.apache.shiro.web.servlet.SimpleCookie">
        <constructor-arg value="v_v-re-baidu"/>
        <property name="httpOnly" value="true"/>
        <!-- 配置存储rememberMe Cookie的domain为 一级域名
        <property name="domain" value=".itboy.net"/>
         -->
        <property name="maxAge" value="2592000"/><!-- 30天时间，记住我30天 -->
    </bean>

记住我登录的信息配置。和上面配置是一样的道理，可以在相同 一级域名  下的所有域名都可以获取到登录的信息。
四、简单实现了单个帐号只能在一处登录。

我们在其他的系统中可以看到，单个帐号只允许一人使用，在A处登录了，B处再登录，那A处就被踢出了。如下图所示。

但是此功能不是很完美，当A处被踢出后，再重新登录，这时候B处反应有点慢，具体我还没看，因为是之前加的功能，现在凌晨了，下次我有空再瞧瞧，同学你也可以看看，解决了和我说一声，我把功能修复。
五、修复功能（BUG）
1.修复权限添加功能BUG。

之前功能有问题，每当添加一个权限的时候，默认都给角色为“管理员”的角色默认添加当前新添加的权限。这样达到管理员的权限永远是最大的。由于代码有BUG ，导致所有权限删除了。现已修复。
2.修复项目只能部署到Root目录下的问题。

问题描述：之前项目只能部署到Root 下才能正常运行，目前已经修复，可以带项目路径进行访问了，之前只能这样访问，http://localhost:8080  而不能http://localhost:8080/shiro.demo/ 访问，目前是可以了。

解决方案：在 FreeMarkerViewExtend.java 33行处 增加了BasePath ，通过BasePath 来控制请求目录，在 Freemarker  中可以自由使用，而 JSP  中是直接在 JSP  中获取BasePath 使用。

解决后遗症：因为我们的权限是通过URL 来控制的，那么增加了项目的目录，导致权限不能正确的判断，再加上我们的项目名称（目录）可以自定义，导致更不好判断。

后遗症解决方案：PermissionFilter.java 50行处 解决了这个问题，详情请看代码和注释，其实就是replace 了一下。

    HttpServletRequest httpRequest = ((HttpServletRequest)request);
    /**
     * 此处是改版后，为了兼容项目不需要部署到root下，也可以正常运行，但是权限没设置目前必须到root 的URI，
     * 原因：如果你把这个项目叫 ShiroDemo，那么路径就是 /ShiroDemo/xxxx.shtml ，那另外一个人使用，又叫Shiro_Demo,那么就要这么控制/Shiro_Demo/xxxx.shtml 
     * 理解了吗？
     * 所以这里替换了一下，使用根目录开始的URI
     */
    String uri = httpRequest.getRequestURI();//获取URI
    String basePath = httpRequest.getContextPath();//获取basePath
    if(null != uri && uri.startsWith(basePath)){
    	uri = uri.replace(basePath, "");
    }

3.项目启动的时候报错，关于JNDI的错误提示。

其实也不是错，但是看着不舒服，所以还得解决这个问题。解决这个问题需要在web.xml 中的开始部位加入以下代码。

    <context-param>
    	<param-name>spring.profiles.active</param-name>
    	<param-value>dev</param-value>
    </context-param>
    <context-param>
    	<param-name>spring.profiles.default</param-name>
    	<param-value>dev</param-value>
    </context-param>
    <context-param>
    	<param-name>spring.liveBeansView.mbeanDomain</param-name>
    	<param-value>dev</param-value>
    </context-param>

4.项目Maven打包问题。

打包的时候，不同版本的 Eclipse  还有IDEA 会有打包打不进去Mapper.xml 文件，这个时候要加如下代码（群里同学提供的）。

    <resources>
    	<resource>
    		<directory>src/main/java</directory>
    		<includes>
    			<include>**/*.properties</include>
    			<include>**/*.xml</include>
    		</includes>
    		<filtering>false</filtering>
    	</resource>
    </resources>

在<build> 标签内加入即可，如果还是不能解决，那么请你加群（改名后）说明你的问题，有人会回答你。
5.Tomcat7以上在访问JSP页面的时候，提示JSTL错误。

这个错误是因为Tomcat7 中没有 JSTL  的jar包，现在已经在项目pom.xml 中增加了如下 jar  的引入管理。

    <dependency>
    	<groupId>javax.servlet</groupId>
    	<artifactId>jstl</artifactId>
    	<version>1.2</version>
    </dependency>
    <dependency>
    	<groupId>javax.servlet</groupId>
    	<artifactId>jsp-api</artifactId>
    	<version>2.0</version>
    	<scope>provided</scope>
    </dependency>

如果还是不能解决问题，请在官方群（群号：259217951）内搜索“jstl” 如图下载依赖包。

