import QtQuick 2.0

Canvas {
    //@detalis rightTime Indicates the completion time of the graph on the display.
    property var rightTime: 1546564800
    ///@detalis maxXLine Indicates the maximum number of vertical lines.
    property int maxXLine: 6
    ///@detalis maxYLine Indicates the maximum number of horisontal lines.
    property int maxYLine: 10
    ///@detalis heightNoLine Indicates an indentation at the top where horizontal lines are not displayed.
    property int heightNoLine: 40*pt
    ///@detalis marginHorizontalLineToYAxisText Indicates the indent between text and lines.
    property int marginHorizontalLineToYAxisText:14 * pt
    ///@detalis rightTextField Width of the right text box.
    property int rightTextField: 31 * pt
    ///@detalis bottomOutLine The height of the line protrusion below the graph field.
    property int bottomOutLine: 4 * pt
    ///@detalis fontColorArea Axial font color.
    property string fontColorArea: "#757184"
    ///@detalis fontSizeArea Size font.
    property int fontSizeArea: 10 * pt
    ///@detalis topMarginXAxisText Indicates the indent between text and lines.
    property int topMarginXAxisText: 8 * pt
    ///@detalis lineColorArea Line color.
    property string lineColorArea: "#C7C6CE"
    ///@detalis lineWidthArea Width color.
    property int lineWidthArea: 1
    ///@detalis candleColorUp Bull color.
    property string candleColorUp:"#6F9F00"
    ///@detalis candleColorDown Bear candle color
    property string candleColorDown:"#EB4D4B"
    ///@detalis candleWidthLine Width candle.
    property int candleWidthLine: 1 * pt
    ///@detalis candleWidth Width body candle.
    property int candleWidth: 5 * pt
    ///@detalis imageCursorPath Path icon flug current.
    property string imageCursorPath:"qrc:/res/icons/ic_flag.png"
    ///@detalis imageCursorWidth Width icon.
    property int imageCursorWidth: 44 * pt
    ///@detalis imageCursorHeight Height icon.
    property int imageCursorHeight: 16 * pt
    ///@detalis colorCursorLine Cursor line color.
    property string colorCursorLine:"#070023"
    ///@detalis colorCursorFont Cursor font color.
    property string colorCursorFont: "#FFFFFF"
    ///@detalis fontSizeCursor Cursor font size.
    property int fontSizeCursor: 10*pt
    ///@detalis currentValue Current value price.
    property int currentValue: 10236
    ///@detalis stepTime Time step for vertical line.
    property int stepTime:thisProperty.hour
    ///@detalis cashCandle The number of candles outside the screen from the right and left.
    property int cashCandle: 5
    ///@detalis isRightTimeCurrent Graphic redraw resolution for offset
    property bool isRightTimeCurrent: false
    ///@detalis moveTimeForVisual Time offset for visualization of vertical stripes
    property var moveTimeForVisual: 20*thisProperty.minute
    ///@detalis currentValueTime Data update time for the current price value.
    property int currentValueTime:10000
    ///@detalis timeReloadCanvas Screen refresh time when the graph is shifted.
    property int timeReloadCanvas:30

    //For private values.
    QtObject {
        id: thisProperty
        ///@detalis minValuePrice Axis minimum value.
        property int minValuePrice: 10000
        ///@detalis maxValuePrice Axis maximum value.
        property int maxValuePrice: 10800
        //Graphics working field.
        ///@detalis fieldXMin Minimum value x.
        property int fieldXMin: 0
        ///@detalis fieldXMax Maximum value x.
        property int fieldXMax: 100
        ///@detalis fieldYMin Minimum value y.
        property int fieldYMin: 0
        ///@detalis fieldYMax Maximum value y.
        property int fieldYMax: 100
        //Variables for setting time.
        //Year.
        property int year: 31556926;
        //Month.
        property int month: 2629743;
        //Week.
        property int week: 604800;
        //Day.
        property int day: 86400;
        //Hour.
        property int hour: 3600;
        //Minute.
        property int minute: 60;
        ///@detalis yRealFactor Coordinate multiplier y.
        property var yRealFactor: 0.0
        ///@detalis xRealFactor Coordinate multiplier x.
        property var xRealFactor: 0.0
        ///@detalis intervalPrice The gap between the minimum and maximum values on the y axis.
        property var intervalPrice: 0.0
        ///@detalis positionMouseX Temporarily remembers the position of the mouse to calculate the offset.
        property int positionMouseX:0
        ///@detalis modelCountMin The minimum value of the counter for the passage of values (constantly recounted).
        property int modelCountMin: 0
        ///@detalis modelCountMax The maximum value of the counter for the passage of values (constantly recounted).
        property int modelCountMax: candleModel.count
        ///@detalis currentTime Time current.
        property var currentTime: new Date()

    }

    id: chartCanvas

    Component.onCompleted: {
        loadImage(imageCursorPath);
    }
    onPaint: {
        canvasPaint();
    }

    //Price change timer.
    Timer{
        id:currentTimer
        repeat: true
        interval: currentValueTime
        onTriggered: {
            thisProperty.currentTime = new Date();
            if(isRightTimeCurrent)rightTime = thisProperty.currentTime;
            canvasPaint();
        }
    }

    MouseArea{
        id:areaCanvas
        anchors.fill: parent

       //Image refresh timer.
        Timer{
            id:moveTimer
            repeat: true
            interval: timeReloadCanvas
            onTriggered: {
                if(rightTime < thisProperty.currentTime)
                {
                    rightTime = rightTime + (thisProperty.positionMouseX-areaCanvas.mouseX)*thisProperty.xRealFactor;
                    canvasPaint();
                    thisProperty.positionMouseX = areaCanvas.mouseX
                    isRightTimeCurrent = true;
                }
                else
                { var tmpRightTime = (thisProperty.positionMouseX-areaCanvas.mouseX)*thisProperty.xRealFactor;
                    if(tmpRightTime<0)
                    {
                        rightTime = rightTime + (thisProperty.positionMouseX-areaCanvas.mouseX)*thisProperty.xRealFactor;
                        canvasPaint();
                        thisProperty.positionMouseX = areaCanvas.mouseX
                        isRightTimeCurrent = false;
                    }
                }
            }
        }

        onPressed: {
            if(mouse.button === Qt.LeftButton) {

                thisProperty.positionMouseX = mouseX;
                moveTimer.start();
            }
        }

        onReleased: {
            moveTimer.stop();
            autoSetDisplayCandle();
        }
    }

    //Drawing a graph on the screen.
    function canvasPaint()
    {
        autoSetWidthPrice()
        init();
        var ctx = getContext("2d");
        ctx.clearRect(0,0,parent.width,parent.height)
        timeToXLineChart(ctx);
        valuePriceYLineChart(ctx);
        fillCandle(ctx);
        chartCanvas.requestPaint();
    }

    //Configuring candlestick options for rendering.
    function autoSetDisplayCandle()
    {
        var valueActualTime = stepTime*maxXLine;
        var minTime = rightTime - valueActualTime;
        var isFirst = false;
        var isEnded = false;
        var firstCandle = 0;
        var endedCandle = thisProperty.modelCountMax;
        for (var count = thisProperty.modelCountMin;count<thisProperty.modelCountMax;count++)
        {
            if(!isFirst | minTime > candleModel.get(count).time)
            {
                isFirst = true;
                if(count>10)thisProperty.modelCountMin = count-cashCandle;
                else thisProperty.modelCountMin = 0;
            }
            if(!isEnded | rightTime>candleModel.get(count).time)
            {
                isEnded = true;
                if(count < candleModel.count-10)thisProperty.modelCountMax = count+cashCandle;
                else thisProperty.modelCountMax = candleModel.count;
            }
        }
    }

    ///Auto selection of the lower and upper limit.
    function autoSetWidthPrice()
    {
        autoSetDisplayCandle();
        var minPrice = candleModel.get(thisProperty.modelCountMin).minimum;
        var maxPrice = candleModel.get(thisProperty.modelCountMin).maximum;

        for(var count = thisProperty.modelCountMin; count < thisProperty.modelCountMax; count++)
        {

            if(minPrice > candleModel.get(count).minimum) minPrice = candleModel.get(count).minimum;
            if(maxPrice < candleModel.get(count).maximum) maxPrice = candleModel.get(count).maximum;
        }
        thisProperty.maxValuePrice = maxPrice;
        thisProperty.minValuePrice = minPrice;
    }

    ///Initiation property.
    function init(){
        thisProperty.fieldXMax = chartCanvas.width - rightTextField - marginHorizontalLineToYAxisText;
        thisProperty.fieldYMax = chartCanvas.height - fontSizeArea - topMarginXAxisText - bottomOutLine;
        thisProperty.intervalPrice = thisProperty.maxValuePrice - thisProperty.minValuePrice;
        thisProperty.yRealFactor = thisProperty.intervalPrice / (thisProperty.fieldYMax - thisProperty.fieldYMin);
        thisProperty.xRealFactor = (stepTime*maxXLine)/(thisProperty.fieldXMax-thisProperty.fieldXMin);
    }

    //Time conversion.
    function timeToXChart(TimeX)
    {
        var a = new Date(TimeX * 1000);
        var hour = a.getHours();
        if(hour<10)hour = '0'+hour;
        var min = a.getMinutes();
        if(min<10)min='0'+min;
        var time = hour + ':' + min;
        return time;
    }

    //X grid calculation and drawing.
    function timeToXLineChart(ctx)
    {
        for(var count = 0; count < maxXLine; count++)
        {
            var timeRound = rightTime%stepTime
            var timeLine = rightTime - (stepTime*count)-timeRound;
            var timeXAxis = ((stepTime * count) + timeRound + moveTimeForVisual)/thisProperty.xRealFactor;
            verticalLineChart(ctx,thisProperty.fieldXMax - timeXAxis,timeToXChart(timeLine + moveTimeForVisual));
        }
    }

    //Y grid calculation  and drawing.
    function valuePriceYLineChart(ctx)
    {
        var realInterval = (thisProperty.fieldYMax - thisProperty.fieldYMin)/maxYLine;

        var priceInterval = thisProperty.intervalPrice / maxYLine;
        var stepPrise = 10;

        for(var scanStep = 1; scanStep < 100000;scanStep*=10)
        {
            if(thisProperty.intervalPrice /scanStep <= maxYLine) {stepPrise = scanStep; break;}
            if(thisProperty.intervalPrice /(scanStep*5) <= maxYLine) {stepPrise = scanStep*5;break;}
        }
        for(var count = 0; count<maxYLine;count++)
        {
            if(count === 0)
            {
                horizontalLineChart(ctx,thisProperty.fieldYMax,"");
            }
            else
                if(thisProperty.fieldYMax-((stepPrise*count/thisProperty.yRealFactor))>heightNoLine)
                {
                    horizontalLineChart(ctx,thisProperty.fieldYMax-((stepPrise*count/thisProperty.yRealFactor)),thisProperty.minValuePrice+stepPrise*count);
                }
        }
        horizontalLineCurrentLevelChart(ctx,thisProperty.fieldYMax - (currentValue - thisProperty.minValuePrice)/thisProperty.yRealFactor,currentValue);
    }

    //Candle drawing.
    function fillCandle(ctx)
    {

        for(var count = thisProperty.modelCountMin; count< thisProperty.modelCountMax ; count++)
        {

            candleVisual(ctx,candleModel.get(count).time,candleModel.get(count).minimum,
                         candleModel.get(count).maximum,candleModel.get(count).open,candleModel.get(count).close);
        }
    }

    //Vertical line draw.
    function verticalLineChart(ctx,x,text)
    {

        ctx.beginPath()
        ctx.lineWidth = lineWidthArea;
        ctx.strokeStyle = lineColorArea;
        ctx.moveTo(x, chartCanvas.height-fontSizeArea-topMarginXAxisText);
        ctx.lineTo(x, 0);
        ctx.font = "normal "+fontSizeArea+ "px Roboto";
        ctx.fillStyle = fontColorArea;
        ctx.fillText(text,x-13,chartCanvas.height);
        ctx.stroke();
    }

    //horizontal line draw.
    function horizontalLineChart(ctx,y,text)
    {
        ctx.beginPath();
        //ctx.save();
        ctx.lineWidth = lineWidthArea;
        ctx.strokeStyle = lineColorArea;
        ctx.moveTo(thisProperty.fieldXMax, y);
        ctx.lineTo(0, y);
        ctx.font = "normal "+fontSizeArea+ "px Roboto";
        ctx.fillStyle = fontColorArea;
        ctx.fillText(text,chartCanvas.width - rightTextField,y+3);
        ctx.stroke();
    }

    //Candle draw.
    function candleVisual(ctx,pointTime,minimum,maximum,open,close)
    {
        var timeXAxis = thisProperty.fieldXMax-(rightTime-pointTime)/thisProperty.xRealFactor;
        if(thisProperty.fieldXMax>timeXAxis)
        {
            ctx.beginPath()
            ctx.lineWidth = candleWidthLine;
            if(open < close)
            {
                ctx.strokeStyle = candleColorUp;
                ctx.fillStyle = candleColorUp;
            }else
            {
                ctx.strokeStyle = candleColorDown;
                ctx.fillStyle = candleColorDown;
            }

            ctx.moveTo(timeXAxis,getYValue(minimum));
            ctx.lineTo(timeXAxis, getYValue(maximum));
            ctx.moveTo(timeXAxis-(candleWidth/2), getYValue(open));
            ctx.lineTo(timeXAxis-(candleWidth/2), getYValue(close));
            ctx.lineTo(timeXAxis+(candleWidth/2), getYValue(close));
            ctx.lineTo(timeXAxis+(candleWidth/2), getYValue(open));
            ctx.lineTo(timeXAxis-(candleWidth/2), getYValue(open));
            ctx.stroke();
            ctx.fill();
        }
    }

    //Converting Values to Coordinates.
    function getYValue(value)
    {
        return thisProperty.fieldYMax - (value - thisProperty.minValuePrice)/thisProperty.yRealFactor;
    }

    //Draw a line with the current value.
    function horizontalLineCurrentLevelChart(ctx,y,text)
    {
        ctx.beginPath()
        ctx.lineWidth = lineWidthArea;
        ctx.strokeStyle = colorCursorLine;
        ctx.moveTo(0, y);
        ctx.lineTo(chartCanvas.width - imageCursorWidth + 4, y);
        ctx.drawImage(imageCursorPath, chartCanvas.width-imageCursorWidth, y-imageCursorHeight/2,imageCursorWidth,imageCursorHeight);
        ctx.font = "normal " +fontSizeCursor+ "px Roboto";
        ctx.fillStyle = colorCursorFont;
        ctx.fillText(text,chartCanvas.width - rightTextField - (5*pt),y+imageCursorHeight/5);
        ctx.stroke();
        chartCanvas.requestPaint();
    }
}




/*##^##
Designer {
    D{i:0;autoSize:true;height:480;width:640}
}
##^##*/
