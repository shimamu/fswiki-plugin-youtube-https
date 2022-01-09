############################################################
#
# YouTube動画を貼る
#
############################################################
package plugin::youtube::Install;

sub install {
	my $wiki = shift;
	$wiki->add_paragraph_plugin("youtube","plugin::youtube::YouTube", "HTML");
}

1;
