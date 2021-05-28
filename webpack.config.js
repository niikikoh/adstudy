const { atanh } = require("core-js/core/number");

const path = require('path');
module.exports = {
    entry: {
        bundle: './src/app.ts'
    },
    output: {
        path: path.join(__dirname,'dist'),
        filename: 'bundle.js'
    },
    resolve: {
        contentBase: path.join(__dirname,'dist')
    },
    module: {
        rules: [
            {
                test:/\.ts$/,loader:'ts-loader'
            }
        ]
    }
}