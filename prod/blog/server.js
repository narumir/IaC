'use strict';

module.exports.handler = async (event) => {
    const body = JSON.stringify({
        message: "hello word",
        // input: event,
    });
    return {
        statusCode: 200,
        body
    };
};
