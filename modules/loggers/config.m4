dnl modules enabled in this directory by default

dnl APACHE_MODULE(name, helptext[, objects[, structname[, default[, config]]]])

APACHE_MODPATH_INIT(loggers)

APACHE_MODULE(syslog, logging to syslog, , , all, [
  AC_CHECK_HEADERS(syslog.h, [ap_HAVE_SYSLOG_H="yes"], [ap_HAVE_SYSLOG_H="no"])
  if test $ap_HAVE_SYSLOG_H = "no"; then
    AC_MSG_WARN([Your system does not support syslog.])
    enable_syslog="no"
  else
    enable_syslog="yes"
  fi
])

APACHE_MODULE(log_config, logging configuration.  You won't be able to log requests to the server without this module., , , yes)
APACHE_MODULE(log_debug, configurable debug logging, , , most)
APACHE_MODULE(log_forensic, forensic logging)

if test "x$enable_log_forensic" != "xno"; then
    # mod_log_forensic needs test_char.h
    APR_ADDTO(INCLUDES, [-I\$(top_builddir)/server])
fi   

APACHE_MODULE(logio, input and output logging, , , most)

APR_ADDTO(INCLUDES, [-I\$(top_srcdir)/$modpath_current])

APACHE_MODPATH_FINISH
