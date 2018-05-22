
<%@ page import="javax.imageio.ImageIO" %>
<%@ page import="java.awt.image.BufferedImage" %>
<%@ page import="java.io.ByteArrayInputStream" %>
<%@ page import="java.io.File" %>
<%@ page import="java.net.URLEncoder" %>
<%@ page import="twitter4j.conf.ConfigurationBuilder" %>
<%@ page import="twitter4j.TwitterFactory" %>
<%@ page import="twitter4j.Twitter" %>
<%@ page import="twitter4j.auth.RequestToken" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <title>ACMS</title>
    <link href="//netdna.bootstrapcdn.com/bootstrap/3.1.0/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
    <script src="//code.jquery.com/jquery-1.11.1.min.js"></script>
    <script src="//netdna.bootstrapcdn.com/bootstrap/3.1.0/js/bootstrap.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.7.2/Chart.min.js"></script>
    <script src="http://www.chartjs.org/dist/2.7.2/Chart.bundle.js"></script>
    <script src="http://www.chartjs.org/samples/latest/utils.js"></script>

    <style>
        .myButton {
            -moz-box-shadow:inset 0px 1px 0px 0px #54a3f7;
            -webkit-box-shadow:inset 0px 1px 0px 0px #54a3f7;
            box-shadow:inset 0px 1px 0px 0px #54a3f7;
            background:-webkit-gradient(linear, left top, left bottom, color-stop(0.05, #007dc1), color-stop(1, #0061a7));
            background:-moz-linear-gradient(top, #007dc1 5%, #0061a7 100%);
            background:-webkit-linear-gradient(top, #007dc1 5%, #0061a7 100%);
            background:-o-linear-gradient(top, #007dc1 5%, #0061a7 100%);
            background:-ms-linear-gradient(top, #007dc1 5%, #0061a7 100%);
            background:linear-gradient(to bottom, #007dc1 5%, #0061a7 100%);
            filter:progid:DXImageTransform.Microsoft.gradient(startColorstr='#007dc1', endColorstr='#0061a7',GradientType=0);
            background-color:#007dc1;
            -moz-border-radius:3px;
            -webkit-border-radius:3px;
            border-radius:3px;
            border:1px solid #124d77;
            display:inline-block;
            cursor:pointer;
            color:#ffffff;
            font-family:Arial;
            font-size:13px;
            padding:15px 15px;
            text-decoration:none;
            text-shadow:0px 1px 0px #154682;
        }
        .myButton:hover {
            background:-webkit-gradient(linear, left top, left bottom, color-stop(0.05, #0061a7), color-stop(1, #007dc1));
            background:-moz-linear-gradient(top, #0061a7 5%, #007dc1 100%);
            background:-webkit-linear-gradient(top, #0061a7 5%, #007dc1 100%);
            background:-o-linear-gradient(top, #0061a7 5%, #007dc1 100%);
            background:-ms-linear-gradient(top, #0061a7 5%, #007dc1 100%);
            background:linear-gradient(to bottom, #0061a7 5%, #007dc1 100%);
            filter:progid:DXImageTransform.Microsoft.gradient(startColorstr='#0061a7', endColorstr='#007dc1',GradientType=0);
            background-color:#0061a7;
        }
        .myButton:active {
            position:relative;
            top:1px;
        }

        .colorgraph {
            height: 5px;
            border-top: 0;
            background: #c4e17f;
            border-radius: 5px;
            background-image: -webkit-linear-gradient(left, #c4e17f, #c4e17f 12.5%, #f7fdca 12.5%, #f7fdca 25%, #fecf71 25%, #fecf71 37.5%, #f0776c 37.5%, #f0776c 50%, #db9dbe 50%, #db9dbe 62.5%, #c49cde 62.5%, #c49cde 75%, #669ae1 75%, #669ae1 87.5%, #62c2e4 87.5%, #62c2e4);
            background-image: -moz-linear-gradient(left, #c4e17f, #c4e17f 12.5%, #f7fdca 12.5%, #f7fdca 25%, #fecf71 25%, #fecf71 37.5%, #f0776c 37.5%, #f0776c 50%, #db9dbe 50%, #db9dbe 62.5%, #c49cde 62.5%, #c49cde 75%, #669ae1 75%, #669ae1 87.5%, #62c2e4 87.5%, #62c2e4);
            background-image: -o-linear-gradient(left, #c4e17f, #c4e17f 12.5%, #f7fdca 12.5%, #f7fdca 25%, #fecf71 25%, #fecf71 37.5%, #f0776c 37.5%, #f0776c 50%, #db9dbe 50%, #db9dbe 62.5%, #c49cde 62.5%, #c49cde 75%, #669ae1 75%, #669ae1 87.5%, #62c2e4 87.5%, #62c2e4);
            background-image: linear-gradient(to right, #c4e17f, #c4e17f 12.5%, #f7fdca 12.5%, #f7fdca 25%, #fecf71 25%, #fecf71 37.5%, #f0776c 37.5%, #f0776c 50%, #db9dbe 50%, #db9dbe 62.5%, #c49cde 62.5%, #c49cde 75%, #669ae1 75%, #669ae1 87.5%, #62c2e4 87.5%, #62c2e4);
        }
        .myButton1 {
            -moz-box-shadow:inset 0px 1px 0px 0px #9fb4f2;
            -webkit-box-shadow:inset 0px 1px 0px 0px #9fb4f2;
            box-shadow:inset 0px 1px 0px 0px #9fb4f2;
            background:-webkit-gradient(linear, left top, left bottom, color-stop(0.05, #7892c2), color-stop(1, #476e9e));
            background:-moz-linear-gradient(top, #7892c2 5%, #476e9e 100%);
            background:-webkit-linear-gradient(top, #7892c2 5%, #476e9e 100%);
            background:-o-linear-gradient(top, #7892c2 5%, #476e9e 100%);
            background:-ms-linear-gradient(top, #7892c2 5%, #476e9e 100%);
            background:linear-gradient(to bottom, #7892c2 5%, #476e9e 100%);
            filter:progid:DXImageTransform.Microsoft.gradient(startColorstr='#7892c2', endColorstr='#476e9e',GradientType=0);
            background-color:#7892c2;
            -moz-border-radius:3px;
            -webkit-border-radius:3px;
            border-radius:3px;
            border:1px solid #4e6096;
            display:inline-block;
            cursor:pointer;
            color:#ffffff;
            font-family:Arial;
            font-size:16px;
            padding:7px 15px;
            text-decoration:none;
            text-shadow:0px 1px 0px #283966;
        }
        .myButton1:hover {
            background:-webkit-gradient(linear, left top, left bottom, color-stop(0.05, #476e9e), color-stop(1, #7892c2));
            background:-moz-linear-gradient(top, #476e9e 5%, #7892c2 100%);
            background:-webkit-linear-gradient(top, #476e9e 5%, #7892c2 100%);
            background:-o-linear-gradient(top, #476e9e 5%, #7892c2 100%);
            background:-ms-linear-gradient(top, #476e9e 5%, #7892c2 100%);
            background:linear-gradient(to bottom, #476e9e 5%, #7892c2 100%);
            filter:progid:DXImageTransform.Microsoft.gradient(startColorstr='#476e9e', endColorstr='#7892c2',GradientType=0);
            background-color:#476e9e;
        }
        .myButton1:active {
            position:relative;
            top:1px;
        }
        .myButton2 {
            -moz-box-shadow:inset 0px 1px 0px 0px #9fb4f2;
            -webkit-box-shadow:inset 0px 1px 0px 0px #9fb4f2;
            box-shadow:inset 0px 1px 0px 0px #9fb4f2;
            background:-webkit-gradient(linear, left top, left bottom, color-stop(0.05, #1cb3ff), color-stop(1, #8ce0fa));
            background:-moz-linear-gradient(top, #1cb3ff 5%, #8ce0fa 100%);
            background:-webkit-linear-gradient(top, #1cb3ff 5%, #8ce0fa 100%);
            background:-o-linear-gradient(top, #1cb3ff 5%, #8ce0fa 100%);
            background:-ms-linear-gradient(top, #1cb3ff 5%, #8ce0fa 100%);
            background:linear-gradient(to bottom, #1cb3ff 5%, #8ce0fa 100%);
            filter:progid:DXImageTransform.Microsoft.gradient(startColorstr='#1cb3ff', endColorstr='#8ce0fa',GradientType=0);
            background-color:#1cb3ff;
            -moz-border-radius:3px;
            -webkit-border-radius:3px;
            border-radius:3px;
            border:1px solid #4e6096;
            display:inline-block;
            cursor:pointer;
            color:#ffffff;
            font-family:Arial;
            font-size:16px;
            padding:7px 15px;
            text-decoration:none;
            text-shadow:0px 1px 0px #283966;
        }
        .myButton2:hover {
            background:-webkit-gradient(linear, left top, left bottom, color-stop(0.05, #8ce0fa), color-stop(1, #1cb3ff));
            background:-moz-linear-gradient(top, #8ce0fa 5%, #1cb3ff 100%);
            background:-webkit-linear-gradient(top, #8ce0fa 5%, #1cb3ff 100%);
            background:-o-linear-gradient(top, #8ce0fa 5%, #1cb3ff 100%);
            background:-ms-linear-gradient(top, #8ce0fa 5%, #1cb3ff 100%);
            background:linear-gradient(to bottom, #8ce0fa 5%, #1cb3ff 100%);
            filter:progid:DXImageTransform.Microsoft.gradient(startColorstr='#8ce0fa', endColorstr='#1cb3ff',GradientType=0);
            background-color:#8ce0fa;
        }
        .myButton2:active {
            position:relative;
            top:1px;
        }


    </style>

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


    }
    catch(Exception e)
    {
        e.printStackTrace();
    }
%>
<div  style="background-color: #006dcc;height: 80px;width:100%;color: white;padding-top: 3px;padding-left: 20px">
    <h1 class="title" >ACMS</h1>
</div>
<div class="container" style="padding-left: 0px">
    <div class="row" style="padding-top: 20px;" >
        <div class="col-sm-3" style="padding-left:30px; padding-right:30px;">
            <div class="row">
                <div class="col-sm-12" style="padding-left:35px;">
                    <div height="30px" width ="25px" ><img src="${pageContext.request.contextPath}/resources/image/fb.png" height="125" width ="125" /></div>
                    <input type="button" style="margin-left:10px" id= "facebookButton"  class="MyButton1" onclick="window.location.href='https://graph.facebook.com/oauth/authorize?client_id=899703630198828&scope=user_friends,user_posts&redirect_uri=<%=URLEncoder.encode("http://localhost:8080/FriendList")%>'" value="CONNECT">
                </div>
            </div>
            <div class="row">
                <div class="col-sm-12" style="padding-left:35px;padding-top:20px;">
                    <div height="30px" width ="25px" ><img src="${pageContext.request.contextPath}/resources/image/tw.png" height="125" width ="125" /></div>
                    <input type="button" id="twitterButton" style="margin-left:10px"  class="MyButton2"  onclick="window.location.href='https://api.twitter.com/oauth/authorize?oauth_token=<%=token%>&oauth_callback=<%=URLEncoder.encode("http://localhost:8080/twitter")%>'" value="CONNECT">
                </div>
            </div>
            <div class="row">
                <div class="col-sm-12" style="padding-top: 30px; padding-left:0px;">
                    <input type="button" id="shareAcrossPlatforms" class="myButton" value="SHARE ACROSS PLATFORMS">
                </div>
            </div>

        </div>
        <div class="col-sm-9">
            <div class="row">
                <div id="divid" width="100%" style="margin:20px; height:400px">
                    <canvas id="myChart" height="0.5" width="0.5" ></canvas>
                </div>
            </div>
            <div class="row">
                <div class="col-md-12">
                    <textarea style= "margin:20px;font-size: 17px; padding:10px; border-radius: 6px; border-color: #bbb;" rows="12" cols="80" name="textBox" id="textBox"  ></textarea>
                </div>
            </div>
            <div class="row" >
                <div class="col-sm-4"></div>
                <div class="col-sm-4">
                    <input type="button"   id="submitPost" class="myButton" value="SUBMIT">
                </div>
                <div class="col-sm-4"></div>
            </div>

        </div>
    </div>
</div>

</body>
<script>
    var i = 0;
    var j =0;
    var year = ${TwitteryearList};

        $(function(){

            $("#shareAcrossPlatforms").click(function(){
                $("#divid").hide();
                $("#textBox").show();
                $("#submitPost").show();

            })

        });




        var config = {
            type: 'line',
            data: {
                labels:${TwitteryearList},
                datasets: [{
                    label: '# Facebook Posts',
                    backgroundColor: window.chartColors.blue,
                    borderColor: window.chartColors.blue,
                    data: ${TwitterpostsList},
                    fill: false,
                },{
                    label: 'My Second dataset',
                    fill: false,
                    backgroundColor: window.chartColors.red,
                    borderColor: window.chartColors.red,
                    data: [],
                }]
            },
            options: {
                responsive: true,
                title: {
                    display: true,
                    text: 'Plots'
                },
                tooltips: {
                    mode: 'index',
                    intersect: false,
                },
                hover: {
                    mode: 'nearest',
                    intersect: true
                },
                scales: {
                    xAxes: [{
                        display: true,
                        scaleLabel: {
                            display: true,
                            labelString: 'Year'
                        }
                    }],
                    yAxes: [{
                        display: true,
                        scaleLabel: {
                            display: true,
                            labelString: '# posts'
                        }
                    }]
                }
            }
        };

        window.onload = function() {
            var ctx = document.getElementById('myChart').getContext('2d');
            window.myLine = new Chart(ctx, config);
            config.data.datasets.splice(1, 2);
            window.myLine.update();

        };


        var colorNames = Object.keys(window.chartColors);
        document.getElementById('ComparitiveAnalysis').addEventListener('click', function() {
            var colorName = colorNames[config.data.datasets.length % colorNames.length];
            var newColor = window.chartColors[colorName];
            var newDataset = {
                label: 'Dataset ' + config.data.datasets.length,
                backgroundColor: newColor,
                borderColor: newColor,
                data: [],
                fill: false
            };

            newDataset.data.push(${TwitteryearList});
            config.data.datasets.push(newDataset);
            window.myLine.update();

        });






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