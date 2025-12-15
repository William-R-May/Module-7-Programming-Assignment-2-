<%@ page import="chapter38.TimeBean, java.util.*, java.text.*" %>
<jsp:useBean id="timeBeanId" 
             class="chapter38.TimeBean" 
             scope="application" />
<html>
<head>
  <title>Display Time</title>
</head>
<body>
  <h3>Current Time</h3>

  <%
    // Safe parsing with fallbacks
    int localeIndex = 0;
    int timeZoneIndex = 0;
    try {
      String li = request.getParameter("localeIndex");
      if (li != null) localeIndex = Integer.parseInt(li);
      String ti = request.getParameter("timeZoneIndex");
      if (ti != null) timeZoneIndex = Integer.parseInt(ti);
    } catch (NumberFormatException ignored) {}

    // Retrieve arrays from bean
    Locale[] locales = timeBeanId.getAllLocale();
    String[] timeZones = timeBeanId.getAllTimeZone();

    // Bounds checking
    if (locales == null || locales.length == 0) {
      locales = new Locale[] { Locale.getDefault() };
    }
    if (timeZones == null || timeZones.length == 0) {
      timeZones = new String[] { TimeZone.getDefault().getID() };
    }
    if (localeIndex < 0 || localeIndex >= locales.length) localeIndex = 0;
    if (timeZoneIndex < 0 || timeZoneIndex >= timeZones.length) timeZoneIndex = 0;

    Locale selectedLocale = locales[localeIndex];
    String selectedTimeZone = timeZones[timeZoneIndex];

    // Get current time for the chosen locale/time zone
    Calendar calendar = Calendar.getInstance(TimeZone.getTimeZone(selectedTimeZone), selectedLocale);
    Date currentTime = calendar.getTime();

    // Format using locale and time zone for a readable, localized string
    DateFormat df = DateFormat.getDateTimeInstance(DateFormat.FULL, DateFormat.FULL, selectedLocale);
    df.setTimeZone(TimeZone.getTimeZone(selectedTimeZone));
    String formattedTime = df.format(currentTime);
  %>

  <p>
    Locale: <%= selectedLocale.toString() %><br />
    Time Zone: <%= selectedTimeZone %><br />
    Current Time: <%= formattedTime %>
  </p>

  <a href="DisplayTimeForm.jsp">Back to Form</a>
</body>
</html>
