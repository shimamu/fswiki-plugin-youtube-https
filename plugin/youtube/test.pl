require "YouTube.pm";

#$str = "http://www.youtube.com/watch?v=C0lgUL1kmNs&feature=dir";
$str = "http://jp.youtube.com/watch?v=4jnf2naLlXw";
$str = "http://www.nicovideo.jp/watch/sm1474833";


# �ƥ��Ȥ���Ȥ��� YouTube.pm��
# $item   = Util::escapeHTML($item);
# �򥳥��ȥ�����

printf("%s\n", 
       plugin::youtube::YouTube::paragraph  ("", "", $str, 320,240)
    );
