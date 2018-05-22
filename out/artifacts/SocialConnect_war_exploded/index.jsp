<%@ page import="java.net.URLEncoder" %>
<%@ page import="twitter4j.conf.ConfigurationBuilder" %>
<%@ page import="twitter4j.TwitterFactory" %>
<%@ page import="twitter4j.Twitter" %>
<%@ page import="twitter4j.auth.RequestToken" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <title>Social Connect</title>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
    <link href="//netdna.bootstrapcdn.com/bootstrap/3.1.0/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
    <script src="//code.jquery.com/jquery-1.11.1.min.js"></script>
    <script src="//netdna.bootstrapcdn.com/bootstrap/3.1.0/js/bootstrap.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.7.2/Chart.min.js"></script>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/customCSS.css">
    <script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
    <script src="http://www.chartjs.org/dist/2.7.2/Chart.bundle.js"></script>
    <script src="http://www.chartjs.org/samples/latest/utils.js"></script>

    <%--<script src="./bootstrapFiles/js/custom-validate.js"></script>--%>
</head>

<body>
<%! String token; %>
<%ConfigurationBuilder cb = new ConfigurationBuilder();
    cb.setDebugEnabled(true).setOAuthConsumerKey("4lR75woUal5o6NasaXnXjVH3l").setOAuthConsumerSecret("2L1AMKrnfdKnm2lJY5Q4P4SaLvhIK8v1thgBZqMzXC7GCW4lPL");
    TwitterFactory tf = new TwitterFactory(cb.build());
    Twitter twitter = tf.getInstance();
    request.getSession().setAttribute("twitter", twitter);
    try {

        // setup callback URL
        String callbackURL = "http://localhost:8080/twitter";
        //int index = callbackURL.lastIndexOf("/");

        // get request object and save to session
        RequestToken requestToken = twitter.getOAuthRequestToken(callbackURL);

        token = requestToken.getToken();
        request.getSession().setAttribute("requestToken", requestToken);
        if(request.getSession().getAttribute("viewAnalysisClicked") == null)
            request.getSession().setAttribute("viewAnalysisClicked", false);

    }
    catch(Exception e)
    {
        e.printStackTrace();
    }
%>
<div  style="font-family: 'Sofia'; background-color: #006dcc;height: 80px;width:100%;color: white;padding-top: 3px;padding-left: 40%;">
    <h1 class="title" >Social Connect</h1>
</div>
<div class="container" style="padding-left: 0px">
    <div class="row" style="padding-top: 20px;" >
        <div class="col-sm-3" style="padding-left:30px; padding-right:30px;">
            <div class="row">
                <div class="col-sm-12" style="padding-left:35px;">
                    <div height="30px" width ="25px" ><img src="${pageContext.request.contextPath}/resources/image/fb.png" height="125" width ="125" /></div>
                    <input type="submit" style="margin-left:10px" id= "facebookButton"  class="MyButton1" value="CONNECT">
                </div>
            </div>
            <div class="row">
                <div class="col-sm-12" style="padding-left:35px;padding-top:20px;">
                    <div height="30px" width ="25px" ><img src="${pageContext.request.contextPath}/resources/image/tw.png" height="125" width ="125" /></div>
                    <input type="button"style="margin-left:10px" id= "twitterButton" class="MyButton2"  value="CONNECT">
                </div>
            </div>
            <div class="row">
                <div class="col-sm-12" style="padding-top: 30px; padding-left:15px;">
                    <input type="button" name="viewAnalysis" id="viewAnalysis" class="myButton" value="VIEW ANALYSIS">
                </div>
            </div>
        </div>
        <div class="col-sm-9">
            <div class="row">
                <div class="col-md-12">
                    <textarea style= "margin:20px;font-size: 17px; padding:10px; border-radius: 6px; border-color: #bbb;" rows="15" cols="80" name="textBox" id="textBox"
                              placeholder="Enter the content that you wish to share in social media"></textarea>
                </div>
            </div>
            <div class="row" >
                <div class="col-sm-4"></div>
                <div class="col-sm-4">
                    <input type="button"   id="submitPost" class="myButton" value="SUBMIT" >
                </div>
                <div class="col-sm-4"></div>
            </div>
            <div class="row">
                <div id="divid" width="100%" style="margin:20px; height:400px">
                    <canvas id="myChart" height="0.5" width="0.5" ></canvas>
                </div>
            </div>


        </div>
        <div class="preload">
            <img src="${pageContext.request.contextPath}/resources/image/loadernew.gif;">
        </div>
    </div>
</div>

</body>
<script>
    var x = "${years}";
    $(function(){
        <%
        Boolean flag = (Boolean)request.getSession().getAttribute("viewAnalysisClicked");
        if(flag==true)
            {
         %>
        var isplot = graphPlot(x);
        if(isplot)
            document.getElementById("viewAnalysis").value= "Post On Social Media";

        <% }%>

        $(".preload").fadeOut(0);
        $("#facebookButton").click(function () {
            $(".preload").show();
            $(".preload").fadeOut(100000);
            window.location.href='https://graph.facebook.com/oauth/authorize?client_id=899703630198828&scope=user_friends,user_posts,publish_actions&redirect_uri=<%=URLEncoder.encode("http://localhost:8080/FriendList")%>'
        });
        $("#twitterButton").click(function () {
            $(".preload").show();
            $(".preload").fadeOut(100000);
            window.location.href='https://api.twitter.com/oauth/authorize?oauth_token=<%=token%>&oauth_callback=<%=URLEncoder.encode("http://localhost:8080/twitter")%>'
        });
        $("#submitPost").click(function(){
            var content  = document.getElementById("textBox").value;
            if(content == "" || content ==" ") {
                swal("Sorry", "Please Enter your Post Content in textbox", "info");
            }
            else{
                var text =  document.getElementById("textBox").value;
                window.location.href='/shareOnSocialMedia?message='+ text;
            }
        });
        $("#viewAnalysis").click(function(){
            var buttonValue = document.getElementById("viewAnalysis").value;
            if(buttonValue.localeCompare("VIEW ANALYSIS")==0) {
                window.location.href = "/result";
            }
            else
            {
                $("#divid").hide();
                $("#textBox").show();
                $("#submitPost").show();
                document.getElementById("viewAnalysis").value= "VIEW ANALYSIS";
                <%
                    request.getSession().setAttribute("viewAnalysisClicked", false);
                %>

            }
        });
        if(window.location.href.indexOf("FriendList") > -1) {
            $(".preload").fadeOut(0);
            swal("Success", "Connected to Facebook", "success");
        }
        if (window.location.href.indexOf("twitter") > -1) {
            swal("Success", "Connected to Twitter", "success");
        }


    });



    function graphPlot(x){
        var x1 = JSON.stringify(x);
        var label;
        var data1;
        var data2;
        var label1;
        var label2;
        var map;

        if(x["length"] == 2){ // rewrite the if condition checking that the accesstocken is set or not

            swal("Sorry!", "You are not connected to Facebook or Twitter", "error");
            return false;

        }
        else {

            data1 = ${postsList}
                data2 = ${TwitterpostsList}
                    label1 = ${yearList}
                        label2 = ${TwitteryearList}

                            // console.log(data1,data2,label1,label2);
                            label = ${years}
                                $("#divid").show();
            $("#textBox").hide();
            $("#submitPost").hide();
        }
        var fbdps=[[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[]];
        var fb_xValue;
        var fb_yValue;

        <c:forEach items="${fbMap}" var="entry" varStatus="loop">
        fb_xValue = ${entry.key};
        fb_yValue = ${entry.value};
        fbdps[parseInt("${loop.index}")].push({
            x : fb_xValue,
            y : fb_yValue
        });
        </c:forEach>
        var twdps=[[],[],[],[],[],[],[],[],[],[]];
        var tw_xValue;
        var tw_yValue;

        <c:forEach items="${twMap}" var="entry" varStatus="loop">
        tw_xValue = ${entry.key};
        tw_yValue = ${entry.value};
        twdps[parseInt("${loop.index}")].push({
            x : tw_xValue,
            y : tw_yValue
        });
        </c:forEach>

        console.log(twdps);
        var i=0;

        var ctx = document.getElementById("myChart").getContext('2d');
        var myChart = new Chart(ctx, {
            type: 'line',
            data: {
                // labels: ["Red", "Blue", "Yellow", "Green", "Purple", "Orange"],
                labels: label,
                datasets: [{
                    label: '# of Posts from Facebook',
                    data: [fbdps[0][0],fbdps[1][0],fbdps[2][0],fbdps[3][0],fbdps[4][0],fbdps[5][0],fbdps[6][0],fbdps[7][0],fbdps[8][0],fbdps[9][0],fbdps[10][0],fbdps[11][0],fbdps[12][0],fbdps[13][0],fbdps[14][0],fbdps[15][0]],
                    showline: true,
                    backgroundColor: window.chartColors.blue,
                    borderColor: window.chartColors.blue,
                    fill : false
                }, {
                    label: '# Twitter',
                    fill: false,
                    showline:true,
                    backgroundColor: window.chartColors.red,
                    borderColor: window.chartColors.red,
                    data: [twdps[0][0],twdps[1][0],twdps[2][0],twdps[3][0],twdps[4][0],twdps[5][0]]
                }]
            },
            options: {
                scales: {
                    yAxes: [{
                        ticks: {
                            beginAtZero:true
                        }
                    }]
                }
            }
        });
        return true;
    }



    $(function(){

        $('.button-checkbox').each(function(){
            var $widget = $(this),
                $button = $widget.find('button'),
                $checkbox = $widget.find('input:checkbox'),
                color = $button.data('color'),
                settings = {
                    on: {
                        icon: 'glyphicon glyphicon-check'
                    },
                    off: {
                        icon: 'glyphicon glyphicon-unchecked'
                    }
                };

            $button.on('click', function () {
                $checkbox.prop('checked', !$checkbox.is(':checked'));
                $checkbox.triggerHandler('change');
                updateDisplay();
            });

            $checkbox.on('change', function () {
                updateDisplay();
            });

            function updateDisplay() {
                var isChecked = $checkbox.is(':checked');
                // Set the button's state
                $button.data('state', (isChecked) ? "on" : "off");

                // Set the button's icon
                $button.find('.state-icon')
                    .removeClass()
                    .addClass('state-icon ' + settings[$button.data('state')].icon);

                // Update the button's color
                if (isChecked) {
                    $button
                        .removeClass('btn-default')
                        .addClass('btn-' + color + ' active');
                }
                else
                {
                    $button
                        .removeClass('btn-' + color + ' active')
                        .addClass('btn-default');
                }
            }
            function init() {
                updateDisplay();
                // Inject the icon if applicable
                if ($button.find('.state-icon').length == 0) {
                    $button.prepend('<i class="state-icon ' + settings[$button.data('state')].icon + '"></i> ');
                }
            }
            init();
        });
    });
</script>
</html>