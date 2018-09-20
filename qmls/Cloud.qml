import QtQuick 2.0

Rectangle {
    Canvas{
        id: canvas
        anchors.fill: parent


        Component.onCompleted:
        {
            if (typeof Object.extend !== 'function') {
                Object.extend = function (d, s) {
                    for (var k in s) {
                        if (s.hasOwnProperty(k)) {
                            var v = s[k];
                            if (d.hasOwnProperty(k) && typeof d[k] === "object" && typeof v === "object") {
                                Object.extend(d[k], v);
                            } else {
                                d[k] = v;
                            }
                        }
                    }
                    return d;
                };
            }

            cloud.prototype = {
                constructor: cloud,
                render: function () {
                    var cX = this.img.width / 2 - this.puff.img.width / 2,
                        cY = this.img.height / 2 - this.puff.img.height / 2;
                    for (var i = 0; i < this.count; i++) {
                        this.ctx.drawImage(this.puff.img, cX + this.points[i][0], cY + this.points[i][1]);
                    }
                }
            };
        }

        function cloud(properties) {
            var defaults = {
                puffRadius: 32,
                puffColor: {
                    r: 255,
                    g: 255,
                    b: 255
                },
                opacity: 0.33,
                count: 32
            };
            properties = Object.extend(defaults, typeof properties === 'undefined' ? {} : properties);
            this.count = properties.count;
            this.points = [];
            this.minX = 0;
            this.minY = 0;
            this.maxX = 0;
            this.maxY = 0;
            this.pu = new puff({
                radius: properties.puffRadius,
                color: properties.puffColor,
                opacity: properties.opacity
            });
            this.img = document.createElement('canvas');
            this.ctx = this.img.getContext('2d');
            for (var i = 0; i < this.count; i++) {
                var seed = Math.random();
                var x = seed * (properties.puffRadius + seed) * Math.cos(1 + i + seed) * Math.PI;
                var y = seed * (properties.puffRadius + seed) * Math.sin(1 + i + seed) * Math.PI / 2;
                this.minX = Math.min(this.minX, x - properties.puffRadius);
                this.maxX = Math.max(this.maxX, x + properties.puffRadius);
                this.minY = Math.min(this.minY, y - properties.puffRadius);
                this.maxY = Math.max(this.maxY, y + properties.puffRadius);
                this.points.push([x, y]);
            }
            this.img.height = (this.maxY - this.minY) + properties.puffRadius * 2;
            this.img.width = (this.maxX - this.minX) + properties.puffRadius * 2;
            this.render();
        }

        function puff(properties) {
            var color = function (obj) {
                return obj.r + ',' + obj.g + ',' + obj.b;
            }

            canvas.height = canvas.width = properties.radius * 2;
            var grad = context.createRadialGradient(properties.radius, properties.radius, 0, properties.radius, properties.radius, properties.radius);
            grad.addColorStop(0, 'rgba(' + color(properties.color) + ',' + properties.opacity + ')');
            grad.addColorStop(1, 'rgba(' + color(properties.color) + ',0)');
            context.fillStyle = grad;
            context.beginPath();
            context.arc(properties.radius, properties.radius, properties.radius, 0, Math.PI * 2, true);
            context.fill();
            context.closePath();
        }



        property var context
        property var clouds: []
        property var speed: 1.11
        property var cloudCount : width * 0.2666666

        Timer {
            interval: 20
            repeat: true
            running: true

            onTriggered: {
                canvas.requestPaint()
            }
        }
            onPaint: {
                context = canvas.getContext('2d');
                init();
            }

        function init() {
            for (var i = 0; i < cloudCount; i++) {
                var count = Math.random() * 64 + 32,
                    rad = Math.random() * 32 + 32,
                    cl = new cloud({
                        count: count,
                        puffRadius: rad,
                        opacity: Math.random() * 0.1
                    });
                cl.x = Math.random() * (width * 2) - width;
                cl.y = cl.img.height - Math.random() * height / 2;
                cl.speed = speed * .6 + Math.random() * (speed * .4);
                cl.push(cloud);

            }
            update();
            render();
        }

        function update() {
            for (var i = 0; i < cloudCount; i++) {
                if (clouds[i].x + clouds[i].img.width < 0) {
                    clouds[i].x = width + clouds[i].img.width;
                } else {
                    clouds[i].x -= clouds[i].speed;
                }
            }
            setTimeout(update, 1000 / 30);
        }

        function render() {
            requestAnimationFrame(render);
            context.clearRect(0, 0, width, height);
            for (var i = 0; i < cloudCount; i++) {
                context.drawImage(clouds[i].img, clouds[i].x - clouds[i].img.width / 2, clouds[i].y - clouds[i].img.height / 2);
            }
          context.beginPath();
          context.fillText(Math.floor(cloudCount) + ' total clouds', 10, 10);
          context.closePath();
        }
    }

}
