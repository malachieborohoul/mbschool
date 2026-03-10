const nodemailer = require('nodemailer');
const { google } = require('googleapis');

// console.log("CLIENT_ID:", process.env.OAUTH2_CLIENT_ID);
// console.log("REFRESH_TOKEN:", process.env.OAUTH2_REFRESH_TOKEN);
// Setup OAuth2
const oAuth2Client = new google.auth.OAuth2(
  process.env.OAUTH2_CLIENT_ID,
  process.env.OAUTH2_CLIENT_SECRET,
  "https://developers.google.com/oauthplayground"
);

oAuth2Client.setCredentials({ refresh_token: process.env.OAUTH2_REFRESH_TOKEN });

const sendEmail = async (options) => {
  try {
    // Get fresh token every time
    const { token: accessToken } = await oAuth2Client.getAccessToken();

    const transporter = nodemailer.createTransport({
      service: 'gmail',
      auth: {
        type: 'OAuth2',
        user: process.env.AUTH_EMAIL,
        clientId: process.env.OAUTH2_CLIENT_ID,
        clientSecret: process.env.OAUTH2_CLIENT_SECRET,
        refreshToken: process.env.OAUTH2_REFRESH_TOKEN,
        accessToken: accessToken,
      },
      family: 4 // Fixes Render's ENETUNREACH error
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
    console.error("Email Service Error:", error);
    throw error;
  }
};

module.exports = sendEmail;