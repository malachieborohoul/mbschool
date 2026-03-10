const nodemailer = require('nodemailer');
const { google } = require('googleapis');

const oAuth2Client = new google.auth.OAuth2(
  process.env.OAUTH2_CLIENT_ID,
  process.env.OAUTH2_CLIENT_SECRET,
  "https://developers.google.com/oauthplayground"
);

oAuth2Client.setCredentials({ refresh_token: process.env.OAUTH2_REFRESH_TOKEN });

const sendEmail = async (options) => {
  try {
    // This is the magic part: it gets a token via HTTPS (Port 443)
    const { token: accessToken } = await oAuth2Client.getAccessToken();

    const transporter = nodemailer.createTransport({
      service: 'gmail', // Use 'service' instead of 'host'
      auth: {
        type: 'OAuth2',
        user: process.env.AUTH_EMAIL,
        clientId: process.env.OAUTH2_CLIENT_ID,
        clientSecret: process.env.OAUTH2_CLIENT_SECRET,
        refreshToken: process.env.OAUTH2_REFRESH_TOKEN,
        accessToken: accessToken,
      },
    });

    const mailOptions = {
      from: `MbSchool <${process.env.AUTH_EMAIL}>`,
      to: options.email,
      subject: options.subject,
      text: options.message,
      html: options.html,
    };

    return await transporter.sendMail(mailOptions);
  } catch (error) {
    console.error("Gmail API Error:", error);
    throw error;
  }
};

module.exports = sendEmail;