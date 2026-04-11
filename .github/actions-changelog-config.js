module.exports = {
	types: [
		{ types: [ "Feature", "feature", "feat" ], label: "New Features" },
		{ types: [ "Fix", "fix" ], label: "Bugfixes" },
		{ types: [ "Improvement", "improvement" ], label: "Improvements" },
		{ types: [ "Revert", "revert" ], label: "Reverts" },
		{ types: [ "Other", "other" ], label: "Other Changes" },
		{ types: [ "Skip", "skip" ], label: "Skip" }
	],
	
	excludeTypes: [ "Skip" ],

	renderTypeSection: function (label, commits) {
		let text = `\n## ${label}\n`;

		commits.forEach(commit => {
			text += `- ${commit.subject}\n`;
			if (commit.body) {
				text += `${commit.body}\n`;
			}
		});

		return text;
	},

	renderChangelog: function (release, changes) {
		const now = new Date();
		let text = `# ${release}\n${changes}\n\n`;
		return text;
	}
};
