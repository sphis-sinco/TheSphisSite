package sphis.site.utils;

import funkin.util.macro.GitCommit;

class GitUtils
{
	/**
	 * Get the SHA1 hash of the current Git commit.
	 */
	public static function getGitCommitHash()
		return GitCommit.getGitCommitHash();

	/**
	 * Get the branch name of the current Git commit.
	 */
	public static function getGitBranch()
		return GitCommit.getGitBranch();

	/**
	 * Get whether the local Git repository is dirty or not.
	 */
	public static function getGitHasLocalChanges()
		return GitCommit.getGitHasLocalChanges();
}
