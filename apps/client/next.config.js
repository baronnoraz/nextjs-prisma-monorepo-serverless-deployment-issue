const CopyWebpackPlugin = require('copy-webpack-plugin');

module.exports = {
  reactStrictMode: true,
  webpack: (config, {isServer}) => {
    if (isServer) {
      config.externals.push('_http_common');
    }
    config.plugins.push(
      new CopyWebpackPlugin({
        patterns: [{
          from: '../../node_modules/.prisma/client/schema.prisma',
          to: './'
        }, {
          from: '../../node_modules/.prisma/client/libquery_engine-rhel-openssl-1.0.x.so.node',
          to: './'
        }]
      })
    )
    return config;
  }
};