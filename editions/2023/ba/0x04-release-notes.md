# Release Notes

This is the second edition of the OWASP API Security Top 10 edition, exactly
four years after its first release. A lot has changed in the API (security)
scene. API traffic increased at a fast pace, some API protocols gained a lot
more traction, many new API security vendors/solutions have popped up, and, of
course, attackers have developed new skills and techniques to compromise
APIs. It was about time to get the list of the ten most critical API security
risks updated.

With a more mature API security industry, for the first time, there was [a
public call for data][1]. Unfortunately, no data was contributed, but based on
the project's team experience, careful API security specialist review, and
community feedback on the release candidate, we built this new list. In the
[Methodology and Data section][2], you'll find more details about how this
version was built. For more details about the security risks please refer to the
[API Security Risks section][3].

The OWASP API Security Top 10 2023 is a forward-looking awareness document for
a fast pace industry. It does not replace other TOP 10's. In this edition:

* We've combined Excessive Data Exposure and Mass Assignment focusing on the
  common root cause: object property level authorization validation failures.
* We've put more emphasis on resource consumption, over focusing on the pace
  they are exhausted.
* We've created a new category "Unrestricted Access to Sensitive Business Flows"
  to address new threats, including most of those that can be mitigated using
  rate limiting.
* We added "Unsafe Consumption of APIs" to address something we've started
  seeing: attackers have started looking for a target's integrated services to
  compromise those, instead of hitting the APIs of their target directly. This
  is the right time to start creating awareness about this increasing risk.

APIs play an increasingly important role in modern microservices architecture,
Single Page Applications (SPAs), mobile apps, IoT, etc. The OWASP API Security
Top 10 is a required effort to create awareness about modern API security
issues.

This update was only possible due to the great effort of several volunteers,
listed in the [Acknowledgments][4] section.

Thank you!

[1]: https://owasp.org/www-project-api-security/announcements/cfd/2022/
[2]: ./0xd0-about-data.md
[3]: ./0x10-api-security-risks.md
[4]: ./0xd1-acknowledgments.md
