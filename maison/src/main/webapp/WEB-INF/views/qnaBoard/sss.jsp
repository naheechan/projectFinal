<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="path" value="${pageContext.request.contextPath }"/>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param name="title" value="질문해요"/>
</jsp:include>
<jsp:include page="/WEB-INF/views/common/menuTitle.jsp">
	<jsp:param name="menuTitle" value="질문해요"/>
</jsp:include>


    body {color: lightpink;
        background-color: black;
        margin-top: 1em;
        font-size: 20px;
        font-family: 'Noto Sans KR';
    }


    .black {font-size: 70px;
     font-family: 'Noto Sans KR';
    }

    .bold {font-size: 50px;
     font-family: 'Noto Sans KR';
    }


    .medium {font-size: 30px;
         font-family: 'Noto Sans KR';
    }

    .regular {font-size: 15px;
    }

    


    .container {
        position: relative;
        width: 100%;    
        overflow: hidden;   
    }

    .slider-container {
        position: absolute;
        width:100%;
    }

    .slide {
        position: absolute;
        width: 100%;
        padding:0 20%;
        box-sizing:border-box;
        top: 50%;
        transform: translateY(-50%);
        text-align: center;
        overflow: hidden;
    }

    .slider-container.animated {
        -webkit-transition: left .3s ease-in;
        transition: left .3s ease-in;
    }

    blockquote {
        color: #636363;
        font-weight: 300;
        font-style: italic;
        margin-bottom: 1.5em;
    }

    cite {
        font-size: .75em;
        font-weight: 700;
        font-style: normal;
    }

    /* Utility */
    .simple-list {
        list-style-type: none;
        margin: 0;
        padding: 0;
    }

    /* Nav */
    #prev,
    #next {
        position: absolute;
        top: 50%;
        left:50%;
        transform: translateY(-50%);
        z-index: 999999;
        display: inline-block;
        height: 5em;
        width: 5em;
        border-radius: 50%;
        background-position: center center;
        background-repeat: no-repeat;
        -webkit-transition: all .3s ease-in;
        transition: all .3s ease-in;
    }

    #prev.disabled, #next.disabled { display:none;}

    #prev { background-image: url('arrow-left-out.svg'); margin-left:-480px;}

    #prev:hover { background-image: url('arrow-left-over.svg'); }

    #next {
        margin-left:380px;
        background-image: url('arrow-right-out.svg');
        
    }

    #next:hover { background-image: url('arrow-right-over.svg'); }
            

    .img1 {
             float: right;}


            </style>
        </head>

<body>
    <div class="container">
        <ul class="slider-container simple-list" id="slider">
            <li class="slide">
                 <p style="font-weight:800; Line-height: 80pt;">
                    <span class="black">
                    당신의 자격은?</span></p>
                 <p style="font-weight:600;">
                    <span class="medium">
                    점수로 알아보는 나의 인플루언서 자격 테스트</span></p>
                <br><br><br><br>

            <cite><center>
            <button
            type="button"
            style="color: lightpink; background:black; font-size:2em; font-weight:600; border-radius:0em; padding:30px 120px;"
            onclick="nextPage();">시작하기</button>
            </center></cite></button>
            </li>

            <black>
            <li class="slide">
                    <p style="font-weight:600; Line-height: 10pt;">
                    <span class="bold">
                <cite>01. 당신은 인스타그램을 사용하십니까?</cite></span></p><br><br>

                    그렇다<br><br>
            <center>
                <p class="bullet">

            <button
            type="button"
            style="color: black; background:lightpink; font-size:1.5em; border-radius:1em; padding:10px 20px;"
            onclick="score+=5;nextPage()">5</button><center><br>
            <button
            type="button"
            style="color: black; background:lightpink; font-size:1.5em; border-radius:1em; padding:10px 20px;"
            onclick="score+=4;nextPage()">
            4</button><center><br>
            <button
            type="button"
            style="color: black; background:lightpink; font-size:1.5em; border-radius:1em; padding:10px 20px;"
            onclick="score+=3;nextPage()">
            3</button><center><br>       
            <button
            type="button"
            style="color: black; background:lightpink; font-size:1.5em; border-radius:1em; padding:10px 20px;"
            onclick="score+=2;nextPage()">2</button><center><br>
            <button
            type="button"
            style="color: black; background: lightpink; font-size:1.5em; border-radius:1em; padding:10px 20px;"
            onclick="score+=1;nextPage()">
            1</button><center><br>
                    그렇지 않다
            </center></cite></button>
            </li>


            <li class="slide">
                    <p style="font-weight:600; Line-height: 10pt;">
                    <span class="bold">
                <cite>02. 당신은 팔로잉보다 팔로워가 더 많습니까?</cite></span></p><br><br>

                    그렇다<br><br>
            <center>
                <p class="bullet">

            <button
            type="button"
            style="color: black; background:lightpink; font-size:1.5em; border-radius:1em; padding:10px 20px;"
            onclick="score+=5;nextPage()">5</button><center><br>
            <button
            type="button"
            style="color: black; background:lightpink; font-size:1.5em; border-radius:1em; padding:10px 20px;"
            onclick="score+=4;nextPage()">
            4</button><center><br>
            <button
            type="button"
            style="color: black; background:lightpink; font-size:1.5em; border-radius:1em; padding:10px 20px;"
            onclick="score+=3;nextPage()">
            3</button><center><br>       
            <button
            type="button"
            style="color: black; background:lightpink; font-size:1.5em; border-radius:1em; padding:10px 20px;"
            onclick="score+=2;nextPage()">2</button><center><br>
            <button
            type="button"
            style="color: black; background: lightpink; font-size:1.5em; border-radius:1em; padding:10px 20px;"
            onclick="score+=1;nextPage()">
            1</button><center><br>
                    그렇지 않다
            </center></cite></button>
            </li>






            <li class="slide">
                    <p style="font-weight:600; Line-height: 10pt;">
                    <span class="bold">
                <cite>03. 당신은 협찬, 광고 게시물을 포스팅한 적이 있습니까?</cite></span></p><br><br>

                    그렇다<br><br>
            <center>
                <p class="bullet">

            <button
            type="button"
            style="color: black; background:lightpink; font-size:1.5em; border-radius:1em; padding:10px 20px;"
            onclick="score+=5;nextPage()">5</button><center><br>
            <button
            type="button"
            style="color: black; background:lightpink; font-size:1.5em; border-radius:1em; padding:10px 20px;"
            onclick="score+=4;nextPage()">
            4</button><center><br>
            <button
            type="button"
            style="color: black; background:lightpink; font-size:1.5em; border-radius:1em; padding:10px 20px;"
            onclick="score+=3;nextPage()">
            3</button><center><br>       
            <button
            type="button"
            style="color: black; background:lightpink; font-size:1.5em; border-radius:1em; padding:10px 20px;"
            onclick="score+=2;nextPage()">2</button><center><br>
            <button
            type="button"
            style="color: black; background: lightpink; font-size:1.5em; border-radius:1em; padding:10px 20px;"
            onclick="score+=1;nextPage()">
            1</button><center><br>
                    그렇지 않다
            </center></cite></button>
            </li>
            




            <li class="slide">
                    <p style="font-weight:600; Line-height: 10pt;">
                    <span class="bold">
                <cite>04. 당신은 라이브 방송을 자주 키는 편입니까?</cite></span></p><br><br>

                    그렇다<br><br>
            <center>
                <p class="bullet">

            <button
            type="button"
            style="color: black; background:lightpink; font-size:1.5em; border-radius:1em; padding:10px 20px;"
            onclick="score+=5;nextPage()">5</button><center><br>
            <button
            type="button"
            style="color: black; background:lightpink; font-size:1.5em; border-radius:1em; padding:10px 20px;"
            onclick="score+=4;nextPage()">
            4</button><center><br>
            <button
            type="button"
            style="color: black; background:lightpink; font-size:1.5em; border-radius:1em; padding:10px 20px;"
            onclick="score+=3;nextPage()">
            3</button><center><br>       
            <button
            type="button"
            style="color: black; background:lightpink; font-size:1.5em; border-radius:1em; padding:10px 20px;"
            onclick="score+=2;nextPage()">2</button><center><br>
            <button
            type="button"
            style="color: black; background: lightpink; font-size:1.5em; border-radius:1em; padding:10px 20px;"
            onclick="score+=1;nextPage()">
            1</button><center><br>
                    그렇지 않다
            </center></cite></button>
            </li>

            



            <li class="slide">
                    <p style="font-weight:600; Line-height: 10pt;">
                    <span class="bold">
                <cite>05. 모르는 사람이 당신을 알아보는 편입니까?</cite></span></p><br><br>

                    그렇다<br><br>
            <center>
                <p class="bullet">

            <button
            type="button"
            style="color: black; background:lightpink; font-size:1.5em; border-radius:1em; padding:10px 20px;"
            onclick="score+=5;nextPage()">5</button><center><br>
            <button
            type="button"
            style="color: black; background:lightpink; font-size:1.5em; border-radius:1em; padding:10px 20px;"
            onclick="score+=4;nextPage()">
            4</button><center><br>
            <button
            type="button"
            style="color: black; background:lightpink; font-size:1.5em; border-radius:1em; padding:10px 20px;"
            onclick="score+=3;nextPage()">
            3</button><center><br>       
            <button
            type="button"
            style="color: black; background:lightpink; font-size:1.5em; border-radius:1em; padding:10px 20px;"
            onclick="score+=2;nextPage()">2</button><center><br>
            <button
            type="button"
            style="color: black; background: lightpink; font-size:1.5em; border-radius:1em; padding:10px 20px;"
            onclick="score+=1;nextPage()">
            1</button><center><br>
                    그렇지 않다
            </center></cite></button>
            </li>





            <li class="slide">
                    <p style="font-weight:600; Line-height: 10pt;">
                    <span class="bold">
                <cite>06. 사람들이 당신과 함께 사진 찍기를 원합니까?</cite></span></p><br><br>

                    그렇다<br><br>
            <center>
                <p class="bullet">

            <button
            type="button"
            style="color: black; background:lightpink; font-size:1.5em; border-radius:1em; padding:10px 20px;"
            onclick="score+=5;nextPage()">5</button><center><br>
            <button
            type="button"
            style="color: black; background:lightpink; font-size:1.5em; border-radius:1em; padding:10px 20px;"
            onclick="score+=4;nextPage()">
            4</button><center><br>
            <button
            type="button"
            style="color: black; background:lightpink; font-size:1.5em; border-radius:1em; padding:10px 20px;"
            onclick="score+=3;nextPage()">
            3</button><center><br>       
            <button
            type="button"
            style="color: black; background:lightpink; font-size:1.5em; border-radius:1em; padding:10px 20px;"
            onclick="score+=2;nextPage()">2</button><center><br>
            <button
            type="button"
            style="color: black; background: lightpink; font-size:1.5em; border-radius:1em; padding:10px 20px;"
            onclick="score+=1;nextPage()">
            1</button><center><br>
                    그렇지 않다
            </center></cite></button>
            </li>




            <li class="slide">
                    <p style="font-weight:600; Line-height: 10pt;">
                    <span class="bold">
                <cite>07. 당신은 모르는 사람에게 DM을 많이 받는 편입니까?</cite></span></p><br><br>

                    그렇다<br><br>
            <center>
                <p class="bullet">

            <button
            type="button"
            style="color: black; background:lightpink; font-size:1.5em; border-radius:1em; padding:10px 20px;"
            onclick="score+=5;nextPage()">5</button><center><br>
            <button
            type="button"
            style="color: black; background:lightpink; font-size:1.5em; border-radius:1em; padding:10px 20px;"
            onclick="score+=4;nextPage()">
            4</button><center><br>
            <button
            type="button"
            style="color: black; background:lightpink; font-size:1.5em; border-radius:1em; padding:10px 20px;"
            onclick="score+=3;nextPage()">
            3</button><center><br>       
            <button
            type="button"
            style="color: black; background:lightpink; font-size:1.5em; border-radius:1em; padding:10px 20px;"
            onclick="score+=2;nextPage()">2</button><center><br>
            <button
            type="button"
            style="color: black; background: lightpink; font-size:1.5em; border-radius:1em; padding:10px 20px;"
            onclick="score+=1;nextPage()">
            1</button><center><br>
                    그렇지 않다
            </center></cite></button>
            </li>

           


            <li class="slide">
                    <p style="font-weight:600; Line-height: 10pt;">
                    <span class="bold">
                <cite>08. 당신은 보여주기식 게시물을 자주 올리는 편입니까?</cite></span></p><br><br>

                    그렇다<br><br>
            <center>
                <p class="bullet">

            <button
            type="button"
            style="color: black; background:lightpink; font-size:1.5em; border-radius:1em; padding:10px 20px;"
            onclick="score+=5;nextPage()">5</button><center><br>
            <button
            type="button"
            style="color: black; background:lightpink; font-size:1.5em; border-radius:1em; padding:10px 20px;"
            onclick="score+=4;nextPage()">
            4</button><center><br>
            <button
            type="button"
            style="color: black; background:lightpink; font-size:1.5em; border-radius:1em; padding:10px 20px;"
            onclick="score+=3;nextPage()">
            3</button><center><br>       
            <button
            type="button"
            style="color: black; background:lightpink; font-size:1.5em; border-radius:1em; padding:10px 20px;"
            onclick="score+=2;nextPage()">2</button><center><br>
            <button
            type="button"
            style="color: black; background: lightpink; font-size:1.5em; border-radius:1em; padding:10px 20px;"
            onclick="score+=1;nextPage()">
            1</button><center><br>
                    그렇지 않다
            </center></cite></button>
            </li>



            <li class="slide">
                    <p style="font-weight:600; Line-height: 10pt;">
                    <span class="bold">
                <cite>09. 팔로워들이 당신을 부러워하는 편입니까?</cite></span></p><br><br>

                    그렇다<br><br>
            <center>
                <p class="bullet">

            <button
            type="button"
            style="color: black; background:lightpink; font-size:1.5em; border-radius:1em; padding:10px 20px;"
            onclick="score+=5;nextPage()">5</button><center><br>
            <button
            type="button"
            style="color: black; background:lightpink; font-size:1.5em; border-radius:1em; padding:10px 20px;"
            onclick="score+=4;nextPage()">
            4</button><center><br>
            <button
            type="button"
            style="color: black; background:lightpink; font-size:1.5em; border-radius:1em; padding:10px 20px;"
            onclick="score+=3;nextPage()">
            3</button><center><br>       
            <button
            type="button"
            style="color: black; background:lightpink; font-size:1.5em; border-radius:1em; padding:10px 20px;"
            onclick="score+=2;nextPage()">2</button><center><br>
            <button
            type="button"
            style="color: black; background: lightpink; font-size:1.5em; border-radius:1em; padding:10px 20px;"
            onclick="score+=1;nextPage()">
            1</button><center><br>
                    그렇지 않다
            </center></cite></button>
            </li>

            >
           



            <li class="slide">
                    <p style="font-weight:600; Line-height: 10pt;">
                    <span class="bold">
                <cite>10. 당신은 하루에 오랜시간 인스타그램을 사용하십니까?</cite></span></p><br><br>

                    그렇다<br><br>
            <center>
                <p class="bullet">

            <button
            type="button"
            style="color: black; background:lightpink; font-size:1.5em; border-radius:1em; padding:10px 20px;"
            onclick="score+=5;nextPage()">5</button><center><br>
            <button
            type="button"
            style="color: black; background:lightpink; font-size:1.5em; border-radius:1em; padding:10px 20px;"
            onclick="score+=4;nextPage()">
            4</button><center><br>
            <button
            type="button"
            style="color: black; background:lightpink; font-size:1.5em; border-radius:1em; padding:10px 20px;"
            onclick="score+=3;nextPage()">
            3</button><center><br>       
            <button
            type="button"
            style="color: black; background:lightpink; font-size:1.5em; border-radius:1em; padding:10px 20px;"
            onclick="score+=2;nextPage()">2</button><center><br>
            <button
            type="button"
            style="color: black; background: lightpink; font-size:1.5em; border-radius:1em; padding:10px 20px;"
            onclick="score+=1;nextPage()">
            1</button><center><br>
                    그렇지 않다
            </center></cite></button>
            </li>


           

            <li class="slide">
                <cite id="result">결과</cite>
            </li>


        </ul>

    </div> <!-- end container -->



<jsp:include page="/WEB-INF/views/common/footer.jsp"/>		