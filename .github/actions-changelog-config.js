module.exports = {
	types: [
		{ types: [ "New Feature" ], label: "New Features" },
		{ types: [ "Fix" ], label: "Bugfixes" },
		{ types: [ "Improvement" ], label: "Improvements" },
		{ types: [ "Revert" ], label: "Reverts" },
		{ types: [ "Other" ], label: "Other Changes" }
	],
	
	excludeTypes: [],

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