// Must be global to access the var from the processing.js pde files
var canvasSize = {
    width: 415,
    height: 305,
    top: -437,
    left: 65
};

$(document).ready(function() {
    switchChannel('ch04');

    $('#channelButtons > button').click(function(e) {
        e.preventDefault();
        switchChannel(this.id);
    });

    $('body').keypress(function(e) {
        var currentChannel;
        var code = e.which;
        switch (code) {
            case 32:
                var instance = Processing.getInstanceById('targetcanvas');
                instance.togglePause();
                e.preventDefault();
                return;
                break;
            case 49:
                currentChannel = 'ch01';
                break;
            case 50:
                currentChannel = 'ch02';
                break;
            case 51:
                currentChannel = 'ch03';
                break;
            case 52:
                currentChannel = 'ch04';
                break;
            case 53:
                currentChannel = 'ch05';
                break;
            default:
                console.log('Error - no mapping for key: ' + e.which);
                return;
        }
        switchChannel(currentChannel);
    });
});

function switchChannel(channelId) {
    var channels = {
        'ch01': 'snake',
        'ch02': 'poisson',
        'ch03': 'dotter',
        'ch04': 'boxes',
        'ch05': 'wheel'
    };
    var sketchName = channels[channelId];
    unloadSketch();
    recreateCanvas();
    loadSketch(sketchName);
}

function unloadSketch() {
    var instance = Processing.getInstanceById('targetcanvas');
    if (instance !== undefined) {
        instance.exit();
    }
}

function recreateCanvas() {
    var canvasElement = '<canvas id="targetcanvas" width="' + canvasSize.width + '" height="' + canvasSize.height + '">' +
        'Sorry, your browser does not support HTML5 canvas :(</canvas>';
    $('canvas').remove();
    $('#tv').append(canvasElement);

    // check if this removes touch error on android:
    // $('#targetcanvas').click(function(e) {
    //     e.preventDefault();
    // });
}

function loadSketch(sketchName) {
    var sketch = 'processing/' + sketchName + '.pde';
    var canvas = document.getElementById('targetcanvas');
    Processing.loadSketchFromSources(canvas, [sketch]);
}
