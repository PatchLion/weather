import QtQuick 2.0

Rectangle{
    color: Qt.lighter("#596977")
    Canvas {

        id: canvas
        anchors.fill: parent
        //canvas init
        property var ctx
        property var count: 200
        property var angle: 5
        property var len: 15

        function draw() {
            //清除上一帧
            ctx.clearRect(0, 0, canvas.width, canvas.height);
            //重新绘制
            xiayus();
        }

        function xiayu(x, y, r) {
            ctx.beginPath();
            ctx.moveTo(x, y);

            ctx.lineTo(x + angle, y + len);
            ctx.lineWidth = 2;
            ctx.stroke();
        }
        function xiayus() {
            for (var i = 1; i <= count; i++) {
                xiayu(Math.random() * canvas.width, Math.random() * canvas.height, angle);
            }
        }
        onPaint: {
            canvas.ctx = canvas.getContext("2d")
            ctx.strokeStyle = 'rgba(255, 255, 255, 0.2)';
            draw();
        }

        Timer {
            interval: 130
            repeat: true
            running: true

            onTriggered: {
                canvas.requestPaint()
            }
        }
    }

}
