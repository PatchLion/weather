import QtQuick 2.0

Rectangle{
    color: Qt.lighter("#596977")
    Canvas {

        id: canvas
        anchors.fill: parent
        //canvas init
        property var ctx

        //snowflake particles
        property var mp: 25 //max particles
        property var particles: []
        Component.onCompleted: {
            for (var i = 0; i < mp; i++) {
                particles.push({
                                   x: Math.random() * canvas.width,
                                   y//x-coordinate
                                   : Math.random() * canvas.height,
                                   r//y-coordinate
                                   : Math.random() * 4 + 1,
                                   d//radius
                                   : Math.random() * mp //density
                               })
            }
        }

        //Lets draw the flakes
        function draw() {
            ctx.clearRect(0, 0, canvas.width, canvas.height)

            ctx.fillStyle = "rgba(255, 255, 255, 0.8)"
            ctx.beginPath()
            for (var i = 0; i < mp; i++) {
                var p = particles[i]
                ctx.moveTo(p.x, p.y)
                ctx.arc(p.x, p.y, p.r, 0, Math.PI * 2, true)
            }
            ctx.fill()
            update2()
        }

        function update2(){
            angle += 0.01
            for (var i = 0; i < mp; i++) {
                var p = canvas.particles[i]
                //Updating X and Y coordinates
                //We will add 1 to the cos function to prevent negative values which will lead flakes to move upwards
                //Every particle has its own density which can be used to make the downward movement different for each flake
                //Lets make it more random by adding in the radius
                p.y += Math.cos(angle + p.d) + 1 + p.r / 2
                p.x += Math.sin(angle) * 2

                //Sending flakes back from the top when it exits
                //Lets make it a bit more organic and let flakes enter from the left and right also.
                if (p.x > canvas.width + 5 || p.x < -5 || p.y > canvas.height) {
                    if (i % 3 > 0) //66.67% of the flakes
                    {
                        particles[i] = {
                            x: Math.random() * canvas.width,
                            y: -10,
                            r: p.r,
                            d: p.d
                        }
                    } else {
                        //If the flake is exitting from the right
                        if (Math.sin(angle) > 0) {
                            //Enter from the left
                            particles[i] = {
                                x: -5,
                                y: Math.random() * canvas.height,
                                r: p.r,
                                d: p.d
                            }
                        } else {
                            //Enter from the right
                            particles[i] = {
                                x: canvas.width + 5,
                                y: Math.random() * canvas.height,
                                r: p.r,
                                d: p.d
                            }
                        }
                    }
                }
            }
        }

        //Function to move the snowflakes
        //angle will be an ongoing incremental flag. Sin and Cos functions will be applied to it to create vertical and horizontal movements of the flakes
        property var angle: 0
        onPaint: {
            canvas.ctx = canvas.getContext("2d")
            draw();
        }

        Timer {
            interval: 20
            repeat: true
            running: true

            onTriggered: {
                canvas.requestPaint()
            }
        }
    }

}
