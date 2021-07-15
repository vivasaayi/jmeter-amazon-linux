const { exec } = require('child_process');

const executeCommand = (cmd, successCallback, errorCallback) => {
    exec(cmd, (error, stdout, stderr) => {
        console.log(error);
        console.log(stdout);
        console.log(stderr);
        if (error) {
            console.log(">>>>>> SOME ERROR");
            console.log(error)
            console.log(`error: ${error.message}`);
            if (errorCallback) {
                errorCallback(error.message);
            }
            return;
        }
        console.log(`stdout: ${stdout}`);
        console.log(`stderr: ${stderr}`);
        if (successCallback) {
            successCallback(stdout);
        }
    });
};


module.exports.handler = function () {
    console.log("hello");

    executeCommand("jmeter -n -t /tests/simple-test.jmx", function(){
        console.log("Success")
    }, function() {
        console.log("Error")
    });
}