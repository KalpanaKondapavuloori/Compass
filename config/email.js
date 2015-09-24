/**
 * Email settings
 */

var settings = {
    service: 'Google Mail',
    user: 'petrodconfig@gmail.com',
    pass: 'passwordone'
};

var messages = {
    'newUser': {
        cc: 'Lead,Manager',
        subject: 'Please activate your new Compass account.',
        text: 'Hi <%=fullName%>,\nYou have been added as a new user on Compass. \n\nIn order to activate your account, please visit:\nhttp://localhost:7000/access/activate\nand enter the activation code:\n<%=code%>\n\nThank you for choosing Compass for your project management needs.\nRegards,\nCompass Team',
        html: 'Hi <%=fullName%>,<br>You have been added as a new user on Compass. <br><br>In order to activate your account, please click <a href="http://localhost:7000/access/activate?code=<%=code%>">here</a>.<br><br>Thank you for choosing Compass for your project management needs.<br>Regards,<br>Compass Team'
    },
    'resetPassword': {
        subject: 'Password reset link for your Compass account.',
        text: 'Hi <%=fullName%>,\nYou (or someone  on your behalf) recently requested a password reset for your Compass account. \n\nIn order to reset your password, please visit:\nhttp://localhost:7000/access/reset\nand enter the reset code:\n<%=code%>\n\nThank you for choosing Compass for your project management needs.\nRegards,\nCompass Team',
        html: 'Hi <%=fullName%>,<br>You (or someone  on your behalf) recently requested a password reset for your Compass account. <br><br>In order to reset your password, please click <a href="http://localhost:7000/access/reset?code=<%=code%>">here</a>.<br><br>Thank you for choosing Compass for your project management needs.<br>Regards,<br>Compass Team',
    },
    'issueAssigned': {
        cc: 'Lead',
        subject: 'Issue #<%=issue.externalID%> has been assigned to you',
        text: 'Hi,\nThe following issue has been assigned to you.\n\nIssue No: <%=issue.externalID%>\nTenant: <%=issue.tenant%>\nSummary: <%=issue.summary%>\nComments: <%=issue.comments%>\nLink: http://localhost:7000/issues/<%=issue.id%>\nSFDC: <%= issue.externalURL%>\n\nThis issue will now be available in your queue when you login to Compass.\n\n\nCompass Notifications',
        html: 'Hi,<br>The following issue has been assigned to you.<br><br>Issue No: <%=issue.externalID%><br>Tenant: <%=issue.tenant%><br>Summary: <%=issue.summary%><br>Comments: <%=issue.comments%><br>Link: <a href="http://localhost:7000/issues/<%=issue.id%>">http://localhost:7000/issues/<%=issue.id%></a><br>SFDC: <a href="<%= issue.externalURL%>"><%= issue.externalURL%></a><br><br>This issue will now be available in your queue when you login to Compass.<br><br><br>Compass Notifications',
    },
    'issuePassed': {
        cc: 'Lead',
        subject: 'Issue #<%=issue.externalID%> has been passed by QA',
        text: 'Hi,\nThe following issue which you worked on, has been passed by QA.\n\nIssue No: <%=issue.externalID%>\nTenant: <%=issue.tenant%>\nSummary: <%=issue.summary%>\nComments: <%=issue.comments%>\nLink: http://localhost:7000/issues/<%=issue.id%>\nSFDC: <%= issue.externalURL%>\n\nThis issue will no longer be available in your queue when you login to Compass.\n\n\nCompass Notifications',
        html: 'Hi,<br>The following issue which you worked on, has been passed by QA.<br><br>Issue No: <%=issue.externalID%><br>Tenant: <%=issue.tenant%><br>Summary: <%=issue.summary%><br>Comments: <%=issue.comments%><br>Link: <a href="http://localhost:7000/issues/<%=issue.id%>">http://localhost:7000/issues/<%=issue.id%></a><br>SFDC: <a href="<%= issue.externalURL%>"><%= issue.externalURL%></a><br><br>This issue will no longer be available in your queue when you login to Compass.<br><br><br>Compass Notifications',
    },
    'issueFailed': {
        cc: 'Lead',
        subject: 'Issue #<%=issue.externalID%> has been failed by QA',
        text: 'Hi,\nThe following issue which you worked on, has been failed by QA, and has been reassigned to you.\n\nIssue No: <%=issue.externalID%>\nTenant: <%=issue.tenant%>\nSummary: <%=issue.summary%>\nComments: <%=issue.comments%>\nLink: http://localhost:7000/issues/<%=issue.id%>\nSFDC: <%= issue.externalURL%>\n\nThis issue will now be available in your queue when you login to Compass.\n\n\nCompass Notifications',
        html: 'Hi,<br>The following issue which you worked on, has been failed by QA, and has been reassigned to you.<br><br>Issue No: <%=issue.externalID%><br>Tenant: <%=issue.tenant%><br>Summary: <%=issue.summary%><br>Comments: <%=issue.comments%><br>Link: <a href="http://localhost:7000/issues/<%=issue.id%>">http://localhost:7000/issues/<%=issue.id%></a><br>SFDC: <a href="<%= issue.externalURL%>"><%= issue.externalURL%></a><br><br>This issue will now be available in your queue when you login to Compass.<br><br><br>Compass Notifications',
    }
};

module.exports = {
    settings: settings,
    messages: messages
};
