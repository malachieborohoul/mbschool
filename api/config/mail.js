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
    const { token: accessToken } = await oAuth2Client.getAccessToken();

    const transporter = nodemailer.createTransport({
      host: 'smtp.gmail.com',
      port: 587,
      secure: false, // Use STARTTLS
      auth: {
        type: 'OAuth2',
        user: process.env.AUTH_EMAIL,
        clientId: process.env.OAUTH2_CLIENT_ID,
        clientSecret: process.env.OAUTH2_CLIENT_SECRET,
        refreshToken: process.env.OAUTH2_REFRESH_TOKEN,
        accessToken: accessToken,
      },
      // CRITICAL: This stops the ENETUNREACH error by forcing IPv4
      family: 4, 
      tls: {
        rejectUnauthorized: false
      }
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
    console.error("Gmail API/SMTP Error:", error);
    throw error;
  }
};

module.exports = sendEmail;