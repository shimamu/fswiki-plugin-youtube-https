###############################################################################
#
# <p>���ꤷ��id��YouTubeư���ĥ��ޤ�(https�б�)��</p>
# <pre>
#   {{youtube id}}
# </pre>
# <p>
#��ɽ������������ꤹ�뤳�Ȥ�Ǥ��ޤ���ɸ���425x300�Ǥ���
# <pre>
#   {{youtube id, 320, 240}}
# </pre>
# <p>
#
###############################################################################
package plugin::youtube::YouTube;
use strict;
use LWP::UserAgent;

#==============================================================================
# ���󥹥ȥ饯��
#==============================================================================
sub new {
	my $class = shift;
	my $self = {};
	return bless $self,$class;
}
#==============================================================================
# �ѥ饰��ե᥽�å�
#==============================================================================

# ================================================================================
sub getYouTubeVideoID  {

  my ($str) = @_;

  if (!($str =~ m/https:\/\/www\.youtube\.com\/watch\?/) &&
      !($str =~ m/https:\/\/jp\.youtube\.com\/watch\?/) ) {
      return $str;
  }

  my $vid = "";
  my @ar = split(/\?/, $str);

  return "" if($ar[1] eq "");

  my @ar2 = split(/\&/, $ar[1]);

  my $i;
  for ($i=0; $i< $#ar2+1; $i++){
    if ($ar2[$i] =~ m/^v=/) {
      $vid = substr($ar2[$i], 2, length($ar2[$i])-2);
    }
  }

  return $vid;
}

sub embed_youtube
{
    my $item   = shift;
    my $width  = shift;
    my $height = shift;

    my $id = &getYouTubeVideoID($item);

    my $src = "https://www.youtube.com/v/" . $id;

    my $buf = "<object class=\"YouTube\" width=\"" . $width . "\" height=\"" . $height . "\"><param name=\"movie\" value=\"" . $src . "\"></param><embed src=\"" . $src . "\" type=\"application/x-shockwave-flash\" width=\"" . $width . "\" height=\"" . $height . "\"></embed></object>\n";

    return $buf;
}

# ================================================================================
sub getNicoID
{
    my $item   = shift;
    my $id;

    if ( $item =~ m/https:\/\/www\.nicovideo\.jp\/watch\/(sm[0-9]*)/ ) {
	$id = $1;
    }

    return $id;
}

sub embed_nicovideo
{
    my $item   = shift;
    my $width  = shift;
    my $height = shift;

    my $nicoID = getNicoID($item);

    my $buf = "<iframe width=\"". $width . "\" height=\"". $height . "\" src=\"https://www.nicovideo.jp/thumb/" . $nicoID . "\" scrolling=\"no\" style=\"border:solid 1px #CCC;\" frameborder=\"0\"><a href=\"https://www.nicovideo.jp/watch/" . $nicoID . "\">�ڥ˥��˥�ư���</a></iframe>";

    return $buf;
}

sub paragraph {
	my $self   = shift;
	my $wiki   = shift;
	my $item   = shift;
	my $width  = shift;
	my $height = shift;

	my $buf = "";

	$item   = Util::escapeHTML($item);

	if (($item =~ m/^https:\/\/www\.nicovideo\.jp/ )) {
	    $width  = ($width  eq "")? 312 : int($width);
	    $height = ($height eq "")? 176 : int($height);
	    $buf    = embed_nicovideo($item, $width, $height);
	}

	else {
            # default : YouTube
	    $width  = ($width  eq "")? 425 : int($width);
	    $height = ($height eq "")? 355 : int($height);
	    $buf    = embed_youtube($item, $width, $height);
	}

	return $buf;

}



1;


