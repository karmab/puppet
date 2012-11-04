class customisation::notty  {
    $nottygroup="Unix"
    exec {
    "add_notty_restriction_for_$nottygroup":
	 command =>"echo Defaults:%$nottygroup !requiretty >>/etc/sudoers",
	 path => ["/bin"],
	 unless =>"grep -q $nottygroup /etc/sudoers";
	}
}
