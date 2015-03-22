// Must be global to access the var from the processing.js pde files
var canvasSize = {
    width: 415,
    height: 305
};

$(document).ready(function() {
    switchChannel('ch04');
    $('#channelButtons > button').click(channelButtonClick);
    $('body').keypress(handleKeypress);
});

function channelButtonClick() {
    switchChannel(this.id);
}

function handleKeypress(e) {        
    e.preventDefault();
    var keycode = e.which;
    if (keycode === 32) {
        var instance = Processing.getInstanceById('targetcanvas');
        instance.togglePause();
        return;
    }
    var channelKeycodeMap = {
        '49' : 'ch01',
        '50' : 'ch02',
        '51' : 'ch03',
        '52' : 'ch04',
        '53' : 'ch05'
    };
    switchChannel(channelKeycodeMap[keycode]);
}

function switchChannel(channelId) {
    var channels = {
        'ch01' : 'snake',
        'ch02' : 'poisson',
        'ch03' : 'dotter',
        'ch04' : 'boxes',
        'ch05' : 'wheel'
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
