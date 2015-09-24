module.exports = {
    users: {
        defaults: {
            role: 'Developer'
        }
    },
    issues: {
        list: {
            queue: {
                'QA': 'QA',
                'Developer': 'Dev',
                '*': '*'
            },
            owner: {
                'Developer': '@user',
                '*': '*'
            }
        },
        fields: {
            available: {
                status: ['New', 'Open', 'QA - Pending', 'QA - Failed', 'QA - Passed', 'Released', 'Closed', 'Reopened']
            },
            defaults: {
                status: 'New',
                queue: 'Need To Work'
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
                },
                sideEffects: {
                    activity: {
                        assignedTo: '$currentOwner'
                    },
                    notify: [{
                        to: '@assignee',
                        template: {
                            key: 'issueAssigned',
                            values: {
                                issue: {
                                    id: '#id',
                                    summary: '#subject',
                                    tenant: '#tenant',
                                    comments: '$comments',
                                    externalID: '#external_id',
                                    externalURL: '#external_url'
                                }
                            }
                        }
                    }]
                }
            },
            assignQA: {
                transitions: {
                    status: {
                        '*': 'QA - Pending'
                    },
                    queue: {
                        '*': 'QA'
                    },
                    current_owner: {
                        '*': '$currentOwner'
                    }
                },
                conditions: {
                    status: ['Open', 'Reopened', 'New', 'QA - Failed']
                },
                sideEffects: {
                    activity: {
                        assignedTo: '$currentOwner'
                    },
                    notify: [{
                        to: '@assignee',
                        template: {
                            key: 'issueAssigned',
                            values: {
                                issue: {
                                    id: '#id',
                                    summary: '#subject',
                                    tenant: '#tenant',
                                    comments: '$comments',
                                    externalID: '#external_id',
                                    externalURL: '#external_url'
                                }
                            }
                        }
                    }]
                }
            },
            takeIssueQA: {
                transitions: {
                    current_owner: {
                        '*': '@user'
                    }
                },
                conditions: {
                    status: ['QA - Pending']
                },
                sideEffects: {
                    activity: {
                        assignedTo: '@user'
                    }
                }
            },
            takeIssueDev: {
                transitions: {
                    status: {
                        'Reopened': 'Reopened',
                        '*': 'Open'
                    },
                    current_owner: {
                        '*': '@user'
                    }
                },
                conditions: {
                    status: ['!QA - Pending', '!QA - Passed', '!Released', '!Closed']
                },
                sideEffects: {
                    activity: {
                        assignedTo: '@user'
                    }
                }
            },
            releaseIssue: {
                transitions: {
                    status: {
                        '*': 'Released'
                    },
                    queue: {
                        '*': 'Released'
                    }
                },
                conditions: {
                    status: ['QA - Passed']
                }
            },
            closeIssue: {
                transitions: {
                    status: {
                        '*': 'Closed'
                    },
                    queue: {
                        '*': 'Released'
                    }
                },
                conditions: {
                    status: ['Released']
                }
            },
            reopenIssue: {
                transitions: {
                    status: {
                        '*': 'Reopened'
                    },
                    queue: {
                        '*': 'Need To Work'
                    }
                },
                conditions: {
                    status: ['QA - Passed', 'QA - Failed', 'Closed', 'Released']
                }
            },
            passIssue: {
                transitions: {
                    status: {
                        '*': 'QA - Passed'
                    },
                    queue: {
                        '*': 'Pending Release'
                    }
                },
                conditions: {
                    status: ['QA - Pending']
                },
                sideEffects: {
                    notify: [{
                        to: '@previousOwner',
                        template: {
                            key: 'issuePassed',
                            values: {
                                issue: {
                                    id: '#id',
                                    summary: '#subject',
                                    tenant: '#tenant',
                                    comments: '$comments',
                                    externalID: '#external_id',
                                    externalURL: '#external_url'
                                }
                            }
                        }
                    }]
                }
            },
            failIssue: {
                transitions: {
                    status: {
                        '*': 'QA - Failed'
                    },
                    queue: {
                        '*': 'Dev'
                    }
                },
                conditions: {
                    status: ['QA - Pending']
                },
                sideEffects: {
                    activity: {
                        assignedTo: '@previousOwner'
                    },
                    notify: [{
                        to: '@previousOwner',
                        template: {
                            key: 'issueFailed',
                            values: {
                                issue: {
                                    id: '#id',
                                    summary: '#subject',
                                    tenant: '#tenant',
                                    comments: '$comments',
                                    externalID: '#external_id',
                                    externalURL: '#external_url'
                                }
                            }
                        }
                    }]
                }
            }
        }
    }
};
