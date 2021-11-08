CREATE DEFINER=`root`@`localhost` PROCEDURE `get_issue_info`(IN _issue varchar(50))
BEGIN

CASE
	WHEN (_issue IN (SELECT issue_name FROM guide)) THEN 
		SELECT issue.*, has.code, guide.title
		FROM issue, guide, has
		WHERE _issue = issue.issue_name AND has.name = _issue;
	ELSE 
		SELECT issue.*, has.code
		FROM issue, has 
		WHERE _issue = issue.issue_name AND has.name = _issue;
END CASE;
END