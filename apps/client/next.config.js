module.exports = {
  reactStrictMode: true,
  webpack: (config, {isServer}) => {
    if (isServer) {
      config.externals.push('_http_common');
    }
    return config;
  }
};