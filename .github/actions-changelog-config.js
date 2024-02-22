module.exports = {
	types: [
		{ types: [ "feature", "new feature" ], label: "🎉 New Features" },
		{ types: [ "bug", "fix" ], label: "🐛 Bugfixes" },
		{ types: [ "improvement" ], label: "🔨 Improvements" },
		{ types: [ "revert" ], label: "🔙 Reverts" },
		{ types: [ "other" ], label: "🔨 Other Changes" }
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