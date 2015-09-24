module.exports = {
    queues: {
        items: ['Need to Work', 'Dev', 'QA', 'Released']
    },
    issues: {
        fields: {
            available: {
                status: ['New', 'Open', 'QA - Pending', 'QA - Failed', 'QA - Passed', 'Released', 'Closed', 'Reopened']
            },
            defaults: {
                status: 'New',
                queue: 'Need to Work'
            }
        },
        flows: {
            assignDev: {
                transitions: {
                    status: {
                        'New': 'Open',
                        '*': 'Reopened'
                    },
                    queue: {
                        '*': 'Dev'
                    },
                    current_owner: {
                        '*': '$currentOwner'
                    }
                },
                conditions: {
                    status: ['!QA - Pending', '!QA - Passed']
                }
            }
        }
    }
};
