<script language="JavaScript" type="text/javascript">
	dmxListToTree({
	  bullets : 'plusminus',
	  icons   : true,
	  struct  : false,
	  objId   : 'FolderView'
	});
</script>

<ul class="dmxtree" id="FolderView">
	<?php
		$s_pw = 'FTP_Easy-UP'; //put your password here

		if($_GET['pw']==$s_pw) {
				ListDirs("./");
		}
	?>
</ul>

<?php
	function ListDirs($path) {
		//using the opendir function
		$dir_handle = @opendir($path) or die("Unable to open $path !");

		//Leave only the lastest folder name
		$dirname = end(explode("/", $path));

		//display the target folder.
		echo ('<li><a href="'.$path.'">'."$dirname</a>\n");
		echo "<ul>\n";

		while (false !== ($file = readdir($dir_handle)))
		{
			if($file!="." && $file!="..")
			{
				if (is_dir($path."/".$file))
				{
					//Display a list of sub folders.
					ListDirs($path."/".$file);
				}
				else
				{
					//Display a list of files.
					//~ echo "<li>$file</li>";
				}
			}
		}
		echo "</ul>\n";
		echo "</li>\n";


		//closing the directory
		closedir($dir_handle);
	}
?>
