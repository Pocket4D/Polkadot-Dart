const metaJson = {
  "magicNumber": 1635018093,
  "metadata": {
    "V12": {
      "modules": [
        {
          "name": "System",
          "storage": {
            "prefix": "System",
            "items": [
              {
                "name": "Account",
                "modifier": "Default",
                "type": {
                  "Map": {
                    "hasher": "Blake2_128Concat",
                    "key": "AccountId",
                    "value": "AccountInfo",
                    "linked": false
                  }
                },
                "fallback":
                    "0x000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
                "documentation": [" The full account information for a particular account ID."]
              },
              {
                "name": "ExtrinsicCount",
                "modifier": "Optional",
                "type": {"Plain": "u32"},
                "fallback": "0x00",
                "documentation": [" Total extrinsics count for the current block."]
              },
              {
                "name": "BlockWeight",
                "modifier": "Default",
                "type": {"Plain": "ExtrinsicsWeight"},
                "fallback": "0x00000000000000000000000000000000",
                "documentation": [" The current weight for the block."]
              },
              {
                "name": "AllExtrinsicsLen",
                "modifier": "Optional",
                "type": {"Plain": "u32"},
                "fallback": "0x00",
                "documentation": [
                  " Total length (in bytes) for all extrinsics put together, for the current block."
                ]
              },
              {
                "name": "BlockHash",
                "modifier": "Default",
                "type": {
                  "Map": {
                    "hasher": "Twox64Concat",
                    "key": "BlockNumber",
                    "value": "Hash",
                    "linked": false
                  }
                },
                "fallback": "0x0000000000000000000000000000000000000000000000000000000000000000",
                "documentation": [" Map of block numbers to block hashes."]
              },
              {
                "name": "ExtrinsicData",
                "modifier": "Default",
                "type": {
                  "Map": {"hasher": "Twox64Concat", "key": "u32", "value": "Bytes", "linked": false}
                },
                "fallback": "0x00",
                "documentation": [
                  " Extrinsics data for the current block (maps an extrinsic's index to its data)."
                ]
              },
              {
                "name": "Number",
                "modifier": "Default",
                "type": {"Plain": "BlockNumber"},
                "fallback": "0x00000000",
                "documentation": [
                  " The current block number being processed. Set by `execute_block`."
                ]
              },
              {
                "name": "ParentHash",
                "modifier": "Default",
                "type": {"Plain": "Hash"},
                "fallback": "0x0000000000000000000000000000000000000000000000000000000000000000",
                "documentation": [" Hash of the previous block."]
              },
              {
                "name": "ExtrinsicsRoot",
                "modifier": "Default",
                "type": {"Plain": "Hash"},
                "fallback": "0x0000000000000000000000000000000000000000000000000000000000000000",
                "documentation": [
                  " Extrinsics root of the current block, also part of the block header."
                ]
              },
              {
                "name": "Digest",
                "modifier": "Default",
                "type": {"Plain": "DigestOf"},
                "fallback": "0x00",
                "documentation": [" Digest of the current block, also part of the block header."]
              },
              {
                "name": "Events",
                "modifier": "Default",
                "type": {"Plain": "Vec<EventRecord>"},
                "fallback": "0x00",
                "documentation": [" Events deposited for the current block."]
              },
              {
                "name": "EventCount",
                "modifier": "Default",
                "type": {"Plain": "EventIndex"},
                "fallback": "0x00000000",
                "documentation": [" The number of events in the `Events<T>` list."]
              },
              {
                "name": "EventTopics",
                "modifier": "Default",
                "type": {
                  "Map": {
                    "hasher": "Blake2_128Concat",
                    "key": "Hash",
                    "value": "Vec<(BlockNumber,EventIndex)>",
                    "linked": false
                  }
                },
                "fallback": "0x00",
                "documentation": [
                  " Mapping between a topic (represented by T::Hash) and a vector of indexes",
                  " of events in the `<Events<T>>` list.",
                  "",
                  " All topic vectors have deterministic storage locations depending on the topic. This",
                  " allows light-clients to leverage the changes trie storage tracking mechanism and",
                  " in case of changes fetch the list of events of interest.",
                  "",
                  " The value has the type `(T::BlockNumber, EventIndex)` because if we used only just",
                  " the `EventIndex` then in case if the topic has the same contents on the next block",
                  " no notification will be triggered thus the event might be lost."
                ]
              },
              {
                "name": "LastRuntimeUpgrade",
                "modifier": "Optional",
                "type": {"Plain": "LastRuntimeUpgradeInfo"},
                "fallback": "0x00",
                "documentation": [
                  " Stores the `spec_version` and `spec_name` of when the last runtime upgrade happened."
                ]
              },
              {
                "name": "UpgradedToU32RefCount",
                "modifier": "Default",
                "type": {"Plain": "bool"},
                "fallback": "0x00",
                "documentation": [
                  " True if we have upgraded so that `type RefCount` is `u32`. False (default) if not."
                ]
              },
              {
                "name": "ExecutionPhase",
                "modifier": "Optional",
                "type": {"Plain": "Phase"},
                "fallback": "0x00",
                "documentation": [" The execution phase of the block."]
              }
            ]
          },
          "calls": [
            {
              "name": "fill_block",
              "args": [
                {"name": "_ratio", "type": "Perbill"}
              ],
              "documentation": [
                " A dispatch that will fill the block weight up to the given ratio."
              ]
            },
            {
              "name": "remark",
              "args": [
                {"name": "_remark", "type": "Bytes"}
              ],
              "documentation": [
                " Make some on-chain remark.",
                "",
                " # <weight>",
                " - `O(1)`",
                " - Base Weight: 0.665 µs, independent of remark length.",
                " - No DB operations.",
                " # </weight>"
              ]
            },
            {
              "name": "set_heap_pages",
              "args": [
                {"name": "pages", "type": "u64"}
              ],
              "documentation": [
                " Set the number of pages in the WebAssembly environment's heap.",
                "",
                " # <weight>",
                " - `O(1)`",
                " - 1 storage write.",
                " - Base Weight: 1.405 µs",
                " - 1 write to HEAP_PAGES",
                " # </weight>"
              ]
            },
            {
              "name": "set_code",
              "args": [
                {"name": "code", "type": "Bytes"}
              ],
              "documentation": [
                " Set the new runtime code.",
                "",
                " # <weight>",
                " - `O(C + S)` where `C` length of `code` and `S` complexity of `can_set_code`",
                " - 1 storage write (codec `O(C)`).",
                " - 1 call to `can_set_code`: `O(S)` (calls `sp_io::misc::runtime_version` which is expensive).",
                " - 1 event.",
                " The weight of this function is dependent on the runtime, but generally this is very expensive.",
                " We will treat this as a full block.",
                " # </weight>"
              ]
            },
            {
              "name": "set_code_without_checks",
              "args": [
                {"name": "code", "type": "Bytes"}
              ],
              "documentation": [
                " Set the new runtime code without doing any checks of the given `code`.",
                "",
                " # <weight>",
                " - `O(C)` where `C` length of `code`",
                " - 1 storage write (codec `O(C)`).",
                " - 1 event.",
                " The weight of this function is dependent on the runtime. We will treat this as a full block.",
                " # </weight>"
              ]
            },
            {
              "name": "set_changes_trie_config",
              "args": [
                {"name": "changes_trie_config", "type": "Option<ChangesTrieConfiguration>"}
              ],
              "documentation": [
                " Set the new changes trie configuration.",
                "",
                " # <weight>",
                " - `O(1)`",
                " - 1 storage write or delete (codec `O(1)`).",
                " - 1 call to `deposit_log`: Uses `append` API, so O(1)",
                " - Base Weight: 7.218 µs",
                " - DB Weight:",
                "     - Writes: Changes Trie, System Digest",
                " # </weight>"
              ]
            },
            {
              "name": "set_storage",
              "args": [
                {"name": "items", "type": "Vec<KeyValue>"}
              ],
              "documentation": [
                " Set some items of storage.",
                "",
                " # <weight>",
                " - `O(I)` where `I` length of `items`",
                " - `I` storage writes (`O(1)`).",
                " - Base Weight: 0.568 * i µs",
                " - Writes: Number of items",
                " # </weight>"
              ]
            },
            {
              "name": "kill_storage",
              "args": [
                {"name": "keys", "type": "Vec<Key>"}
              ],
              "documentation": [
                " Kill some items from storage.",
                "",
                " # <weight>",
                " - `O(IK)` where `I` length of `keys` and `K` length of one key",
                " - `I` storage deletions.",
                " - Base Weight: .378 * i µs",
                " - Writes: Number of items",
                " # </weight>"
              ]
            },
            {
              "name": "kill_prefix",
              "args": [
                {"name": "prefix", "type": "Key"},
                {"name": "_subkeys", "type": "u32"}
              ],
              "documentation": [
                " Kill all storage items with a key that starts with the given prefix.",
                "",
                " **NOTE:** We rely on the Root origin to provide us the number of subkeys under",
                " the prefix we are removing to accurately calculate the weight of this function.",
                "",
                " # <weight>",
                " - `O(P)` where `P` amount of keys with prefix `prefix`",
                " - `P` storage deletions.",
                " - Base Weight: 0.834 * P µs",
                " - Writes: Number of subkeys + 1",
                " # </weight>"
              ]
            },
            {
              "name": "suicide",
              "args": [],
              "documentation": [
                " Kill the sending account, assuming there are no references outstanding and the composite",
                " data is equal to its default value.",
                "",
                " # <weight>",
                " - `O(1)`",
                " - 1 storage read and deletion.",
                " --------------------",
                " Base Weight: 8.626 µs",
                " No DB Read or Write operations because caller is already in overlay",
                " # </weight>"
              ]
            }
          ],
          "events": [
            {
              "name": "ExtrinsicSuccess",
              "args": ["DispatchInfo"],
              "documentation": [" An extrinsic completed successfully. \\[info\\]"]
            },
            {
              "name": "ExtrinsicFailed",
              "args": ["DispatchError", "DispatchInfo"],
              "documentation": [" An extrinsic failed. \\[error, info\\]"]
            },
            {
              "name": "CodeUpdated",
              "args": [],
              "documentation": [" `:code` was updated."]
            },
            {
              "name": "NewAccount",
              "args": ["AccountId"],
              "documentation": [" A new \\[account\\] was created."]
            },
            {
              "name": "KilledAccount",
              "args": ["AccountId"],
              "documentation": [" An \\[account\\] was reaped."]
            }
          ],
          "constants": [
            {
              "name": "BlockHashCount",
              "type": "BlockNumber",
              "value": "0x60090000",
              "documentation": [" The maximum number of blocks to allow in mortal eras."]
            },
            {
              "name": "MaximumBlockWeight",
              "type": "Weight",
              "value": "0x00204aa9d1010000",
              "documentation": [" The maximum weight of a block."]
            },
            {
              "name": "DbWeight",
              "type": "RuntimeDbWeight",
              "value": "0x40787d010000000000e1f50500000000",
              "documentation": [
                " The weight of runtime database operations the runtime can invoke."
              ]
            },
            {
              "name": "BlockExecutionWeight",
              "type": "Weight",
              "value": "0x00f2052a01000000",
              "documentation": [
                " The base weight of executing a block, independent of the transactions in the block."
              ]
            },
            {
              "name": "ExtrinsicBaseWeight",
              "type": "Weight",
              "value": "0x4059730700000000",
              "documentation": [
                " The base weight of an Extrinsic in the block, independent of the of extrinsic being executed."
              ]
            },
            {
              "name": "MaximumBlockLength",
              "type": "u32",
              "value": "0x00005000",
              "documentation": [" The maximum length of a block (in bytes)."]
            }
          ],
          "errors": [
            {
              "name": "InvalidSpecName",
              "documentation": [
                " The name of specification does not match between the current runtime",
                " and the new runtime."
              ]
            },
            {
              "name": "SpecVersionNeedsToIncrease",
              "documentation": [
                " The specification version is not allowed to decrease between the current runtime",
                " and the new runtime."
              ]
            },
            {
              "name": "FailedToExtractRuntimeVersion",
              "documentation": [
                " Failed to extract the runtime version from the new runtime.",
                "",
                " Either calling `Core_version` or decoding `RuntimeVersion` failed."
              ]
            },
            {
              "name": "NonDefaultComposite",
              "documentation": [" Suicide called when the account has non-default composite data."]
            },
            {
              "name": "NonZeroRefCount",
              "documentation": [
                " There is a non-zero reference count preventing the account from being purged."
              ]
            }
          ],
          "index": 0
        },
        {
          "name": "Utility",
          "storage": null,
          "calls": [
            {
              "name": "batch",
              "args": [
                {"name": "calls", "type": "Vec<Call>"}
              ],
              "documentation": [
                " Send a batch of dispatch calls.",
                "",
                " May be called from any origin.",
                "",
                " - `calls`: The calls to be dispatched from the same origin.",
                "",
                " If origin is root then call are dispatch without checking origin filter. (This includes",
                " bypassing `frame_system::Trait::BaseCallFilter`).",
                "",
                " # <weight>",
                " - Complexity: O(C) where C is the number of calls to be batched.",
                " # </weight>",
                "",
                " This will return `Ok` in all circumstances. To determine the success of the batch, an",
                " event is deposited. If a call failed and the batch was interrupted, then the",
                " `BatchInterrupted` event is deposited, along with the number of successful calls made",
                " and the error of the failed call. If all were successful, then the `BatchCompleted`",
                " event is deposited."
              ]
            },
            {
              "name": "as_derivative",
              "args": [
                {"name": "index", "type": "u16"},
                {"name": "call", "type": "Call"}
              ],
              "documentation": [
                " Send a call through an indexed pseudonym of the sender.",
                "",
                " Filter from origin are passed along. The call will be dispatched with an origin which",
                " use the same filter as the origin of this call.",
                "",
                " NOTE: If you need to ensure that any account-based filtering is not honored (i.e.",
                " because you expect `proxy` to have been used prior in the call stack and you do not want",
                " the call restrictions to apply to any sub-accounts), then use `as_multi_threshold_1`",
                " in the Multisig pallet instead.",
                "",
                " NOTE: Prior to version *12, this was called `as_limited_sub`.",
                "",
                " The dispatch origin for this call must be _Signed_."
              ]
            },
            {
              "name": "batch_all",
              "args": [
                {"name": "calls", "type": "Vec<Call>"}
              ],
              "documentation": [
                " Send a batch of dispatch calls and atomically execute them.",
                " The whole transaction will rollback and fail if any of the calls failed.",
                "",
                " May be called from any origin.",
                "",
                " - `calls`: The calls to be dispatched from the same origin.",
                "",
                " If origin is root then call are dispatch without checking origin filter. (This includes",
                " bypassing `frame_system::Trait::BaseCallFilter`).",
                "",
                " # <weight>",
                " - Complexity: O(C) where C is the number of calls to be batched.",
                " # </weight>"
              ]
            }
          ],
          "events": [
            {
              "name": "BatchInterrupted",
              "args": ["u32", "DispatchError"],
              "documentation": [
                " Batch of dispatches did not complete fully. Index of first failing dispatch given, as",
                " well as the error. \\[index, error\\]"
              ]
            },
            {
              "name": "BatchCompleted",
              "args": [],
              "documentation": [" Batch of dispatches completed fully with no error."]
            }
          ],
          "constants": [],
          "errors": [],
          "index": 1
        },
        {
          "name": "Babe",
          "storage": {
            "prefix": "Babe",
            "items": [
              {
                "name": "EpochIndex",
                "modifier": "Default",
                "type": {"Plain": "u64"},
                "fallback": "0x0000000000000000",
                "documentation": [" Current epoch index."]
              },
              {
                "name": "Authorities",
                "modifier": "Default",
                "type": {"Plain": "Vec<(AuthorityId,BabeAuthorityWeight)>"},
                "fallback": "0x00",
                "documentation": [" Current epoch authorities."]
              },
              {
                "name": "GenesisSlot",
                "modifier": "Default",
                "type": {"Plain": "u64"},
                "fallback": "0x0000000000000000",
                "documentation": [
                  " The slot at which the first epoch actually started. This is 0",
                  " until the first block of the chain."
                ]
              },
              {
                "name": "CurrentSlot",
                "modifier": "Default",
                "type": {"Plain": "u64"},
                "fallback": "0x0000000000000000",
                "documentation": [" Current slot number."]
              },
              {
                "name": "Randomness",
                "modifier": "Default",
                "type": {"Plain": "Randomness"},
                "fallback": "0x0000000000000000000000000000000000000000000000000000000000000000",
                "documentation": [
                  " The epoch randomness for the *current* epoch.",
                  "",
                  " # Security",
                  "",
                  " This MUST NOT be used for gambling, as it can be influenced by a",
                  " malicious validator in the short term. It MAY be used in many",
                  " cryptographic protocols, however, so long as one remembers that this",
                  " (like everything else on-chain) it is public. For example, it can be",
                  " used where a number is needed that cannot have been chosen by an",
                  " adversary, for purposes such as public-coin zero-knowledge proofs."
                ]
              },
              {
                "name": "NextEpochConfig",
                "modifier": "Optional",
                "type": {"Plain": "NextConfigDescriptor"},
                "fallback": "0x00",
                "documentation": [" Next epoch configuration, if changed."]
              },
              {
                "name": "NextRandomness",
                "modifier": "Default",
                "type": {"Plain": "Randomness"},
                "fallback": "0x0000000000000000000000000000000000000000000000000000000000000000",
                "documentation": [" Next epoch randomness."]
              },
              {
                "name": "SegmentIndex",
                "modifier": "Default",
                "type": {"Plain": "u32"},
                "fallback": "0x00000000",
                "documentation": [
                  " Randomness under construction.",
                  "",
                  " We make a tradeoff between storage accesses and list length.",
                  " We store the under-construction randomness in segments of up to",
                  " `UNDER_CONSTRUCTION_SEGMENT_LENGTH`.",
                  "",
                  " Once a segment reaches this length, we begin the next one.",
                  " We reset all segments and return to `0` at the beginning of every",
                  " epoch."
                ]
              },
              {
                "name": "UnderConstruction",
                "modifier": "Default",
                "type": {
                  "Map": {
                    "hasher": "Twox64Concat",
                    "key": "u32",
                    "value": "Vec<Randomness>",
                    "linked": false
                  }
                },
                "fallback": "0x00",
                "documentation": [
                  " TWOX-NOTE: `SegmentIndex` is an increasing integer, so this is okay."
                ]
              },
              {
                "name": "Initialized",
                "modifier": "Optional",
                "type": {"Plain": "MaybeRandomness"},
                "fallback": "0x00",
                "documentation": [
                  " Temporary value (cleared at block finalization) which is `Some`",
                  " if per-block initialization has already been called for current block."
                ]
              },
              {
                "name": "AuthorVrfRandomness",
                "modifier": "Default",
                "type": {"Plain": "MaybeRandomness"},
                "fallback": "0x00",
                "documentation": [
                  " Temporary value (cleared at block finalization) that includes the VRF output generated",
                  " at this block. This field should always be populated during block processing unless",
                  " secondary plain slots are enabled (which don't contain a VRF output)."
                ]
              },
              {
                "name": "Lateness",
                "modifier": "Default",
                "type": {"Plain": "BlockNumber"},
                "fallback": "0x00000000",
                "documentation": [
                  " How late the current block is compared to its parent.",
                  "",
                  " This entry is populated as part of block execution and is cleaned up",
                  " on block finalization. Querying this storage entry outside of block",
                  " execution context should always yield zero."
                ]
              }
            ]
          },
          "calls": [
            {
              "name": "report_equivocation",
              "args": [
                {"name": "equivocation_proof", "type": "BabeEquivocationProof"},
                {"name": "key_owner_proof", "type": "KeyOwnerProof"}
              ],
              "documentation": [
                " Report authority equivocation/misbehavior. This method will verify",
                " the equivocation proof and validate the given key ownership proof",
                " against the extracted offender. If both are valid, the offence will",
                " be reported."
              ]
            },
            {
              "name": "report_equivocation_unsigned",
              "args": [
                {"name": "equivocation_proof", "type": "BabeEquivocationProof"},
                {"name": "key_owner_proof", "type": "KeyOwnerProof"}
              ],
              "documentation": [
                " Report authority equivocation/misbehavior. This method will verify",
                " the equivocation proof and validate the given key ownership proof",
                " against the extracted offender. If both are valid, the offence will",
                " be reported.",
                " This extrinsic must be called unsigned and it is expected that only",
                " block authors will call it (validated in `ValidateUnsigned`), as such",
                " if the block author is defined it will be defined as the equivocation",
                " reporter."
              ]
            }
          ],
          "events": null,
          "constants": [
            {
              "name": "EpochDuration",
              "type": "u64",
              "value": "0xc800000000000000",
              "documentation": [
                " The number of **slots** that an epoch takes. We couple sessions to",
                " epochs, i.e. we start a new session once the new epoch begins."
              ]
            },
            {
              "name": "ExpectedBlockTime",
              "type": "Moment",
              "value": "0xb80b000000000000",
              "documentation": [
                " The expected average block time at which BABE should be creating",
                " blocks. Since BABE is probabilistic it is not trivial to figure out",
                " what the expected average block time should be based on the slot",
                " duration and the security parameter `c` (where `1 - c` represents",
                " the probability of a slot being empty)."
              ]
            }
          ],
          "errors": [],
          "index": 2
        },
        {
          "name": "Timestamp",
          "storage": {
            "prefix": "Timestamp",
            "items": [
              {
                "name": "Now",
                "modifier": "Default",
                "type": {"Plain": "Moment"},
                "fallback": "0x0000000000000000",
                "documentation": [" Current time for the current block."]
              },
              {
                "name": "DidUpdate",
                "modifier": "Default",
                "type": {"Plain": "bool"},
                "fallback": "0x00",
                "documentation": [" Did the timestamp get updated in this block?"]
              }
            ]
          },
          "calls": [
            {
              "name": "set",
              "args": [
                {"name": "now", "type": "Compact<Moment>"}
              ],
              "documentation": [
                " Set the current time.",
                "",
                " This call should be invoked exactly once per block. It will panic at the finalization",
                " phase, if this call hasn't been invoked by that time.",
                "",
                " The timestamp should be greater than the previous one by the amount specified by",
                " `MinimumPeriod`.",
                "",
                " The dispatch origin for this call must be `Inherent`.",
                "",
                " # <weight>",
                " - `O(1)` (Note that implementations of `OnTimestampSet` must also be `O(1)`)",
                " - 1 storage read and 1 storage mutation (codec `O(1)`). (because of `DidUpdate::take` in `on_finalize`)",
                " - 1 event handler `on_timestamp_set`. Must be `O(1)`.",
                " # </weight>"
              ]
            }
          ],
          "events": null,
          "constants": [
            {
              "name": "MinimumPeriod",
              "type": "Moment",
              "value": "0xdc05000000000000",
              "documentation": [
                " The minimum period between blocks. Beware that this is different to the *expected* period",
                " that the block production apparatus provides. Your chosen consensus system will generally",
                " work with this to determine a sensible block time. e.g. For Aura, it will be double this",
                " period on default settings."
              ]
            }
          ],
          "errors": [],
          "index": 3
        },
        {
          "name": "Authorship",
          "storage": {
            "prefix": "Authorship",
            "items": [
              {
                "name": "Uncles",
                "modifier": "Default",
                "type": {"Plain": "Vec<UncleEntryItem>"},
                "fallback": "0x00",
                "documentation": [" Uncles"]
              },
              {
                "name": "Author",
                "modifier": "Optional",
                "type": {"Plain": "AccountId"},
                "fallback": "0x00",
                "documentation": [" Author of current block."]
              },
              {
                "name": "DidSetUncles",
                "modifier": "Default",
                "type": {"Plain": "bool"},
                "fallback": "0x00",
                "documentation": [" Whether uncles were already set in this block."]
              }
            ]
          },
          "calls": [
            {
              "name": "set_uncles",
              "args": [
                {"name": "new_uncles", "type": "Vec<Header>"}
              ],
              "documentation": [" Provide a set of uncles."]
            }
          ],
          "events": null,
          "constants": [],
          "errors": [
            {
              "name": "InvalidUncleParent",
              "documentation": [" The uncle parent not in the chain."]
            },
            {
              "name": "UnclesAlreadySet",
              "documentation": [" Uncles already set in the block."]
            },
            {
              "name": "TooManyUncles",
              "documentation": [" Too many uncles."]
            },
            {
              "name": "GenesisUncle",
              "documentation": [" The uncle is genesis."]
            },
            {
              "name": "TooHighUncle",
              "documentation": [" The uncle is too high in chain."]
            },
            {
              "name": "UncleAlreadyIncluded",
              "documentation": [" The uncle is already included."]
            },
            {
              "name": "OldUncle",
              "documentation": [" The uncle isn't recent enough to be included."]
            }
          ],
          "index": 4
        },
        {
          "name": "Indices",
          "storage": {
            "prefix": "Indices",
            "items": [
              {
                "name": "Accounts",
                "modifier": "Optional",
                "type": {
                  "Map": {
                    "hasher": "Blake2_128Concat",
                    "key": "AccountIndex",
                    "value": "(AccountId,BalanceOf,bool)",
                    "linked": false
                  }
                },
                "fallback": "0x00",
                "documentation": [" The lookup from index to account."]
              }
            ]
          },
          "calls": [
            {
              "name": "claim",
              "args": [
                {"name": "index", "type": "AccountIndex"}
              ],
              "documentation": [
                " Assign an previously unassigned index.",
                "",
                " Payment: `Deposit` is reserved from the sender account.",
                "",
                " The dispatch origin for this call must be _Signed_.",
                "",
                " - `index`: the index to be claimed. This must not be in use.",
                "",
                " Emits `IndexAssigned` if successful.",
                "",
                " # <weight>",
                " - `O(1)`.",
                " - One storage mutation (codec `O(1)`).",
                " - One reserve operation.",
                " - One event.",
                " -------------------",
                " - DB Weight: 1 Read/Write (Accounts)",
                " # </weight>"
              ]
            },
            {
              "name": "transfer",
              "args": [
                {"name": "new", "type": "AccountId"},
                {"name": "index", "type": "AccountIndex"}
              ],
              "documentation": [
                " Assign an index already owned by the sender to another account. The balance reservation",
                " is effectively transferred to the new account.",
                "",
                " The dispatch origin for this call must be _Signed_.",
                "",
                " - `index`: the index to be re-assigned. This must be owned by the sender.",
                " - `new`: the new owner of the index. This function is a no-op if it is equal to sender.",
                "",
                " Emits `IndexAssigned` if successful.",
                "",
                " # <weight>",
                " - `O(1)`.",
                " - One storage mutation (codec `O(1)`).",
                " - One transfer operation.",
                " - One event.",
                " -------------------",
                " - DB Weight:",
                "    - Reads: Indices Accounts, System Account (recipient)",
                "    - Writes: Indices Accounts, System Account (recipient)",
                " # </weight>"
              ]
            },
            {
              "name": "free",
              "args": [
                {"name": "index", "type": "AccountIndex"}
              ],
              "documentation": [
                " Free up an index owned by the sender.",
                "",
                " Payment: Any previous deposit placed for the index is unreserved in the sender account.",
                "",
                " The dispatch origin for this call must be _Signed_ and the sender must own the index.",
                "",
                " - `index`: the index to be freed. This must be owned by the sender.",
                "",
                " Emits `IndexFreed` if successful.",
                "",
                " # <weight>",
                " - `O(1)`.",
                " - One storage mutation (codec `O(1)`).",
                " - One reserve operation.",
                " - One event.",
                " -------------------",
                " - DB Weight: 1 Read/Write (Accounts)",
                " # </weight>"
              ]
            },
            {
              "name": "force_transfer",
              "args": [
                {"name": "new", "type": "AccountId"},
                {"name": "index", "type": "AccountIndex"},
                {"name": "freeze", "type": "bool"}
              ],
              "documentation": [
                " Force an index to an account. This doesn't require a deposit. If the index is already",
                " held, then any deposit is reimbursed to its current owner.",
                "",
                " The dispatch origin for this call must be _Root_.",
                "",
                " - `index`: the index to be (re-)assigned.",
                " - `new`: the new owner of the index. This function is a no-op if it is equal to sender.",
                " - `freeze`: if set to `true`, will freeze the index so it cannot be transferred.",
                "",
                " Emits `IndexAssigned` if successful.",
                "",
                " # <weight>",
                " - `O(1)`.",
                " - One storage mutation (codec `O(1)`).",
                " - Up to one reserve operation.",
                " - One event.",
                " -------------------",
                " - DB Weight:",
                "    - Reads: Indices Accounts, System Account (original owner)",
                "    - Writes: Indices Accounts, System Account (original owner)",
                " # </weight>"
              ]
            },
            {
              "name": "freeze",
              "args": [
                {"name": "index", "type": "AccountIndex"}
              ],
              "documentation": [
                " Freeze an index so it will always point to the sender account. This consumes the deposit.",
                "",
                " The dispatch origin for this call must be _Signed_ and the signing account must have a",
                " non-frozen account `index`.",
                "",
                " - `index`: the index to be frozen in place.",
                "",
                " Emits `IndexFrozen` if successful.",
                "",
                " # <weight>",
                " - `O(1)`.",
                " - One storage mutation (codec `O(1)`).",
                " - Up to one slash operation.",
                " - One event.",
                " -------------------",
                " - DB Weight: 1 Read/Write (Accounts)",
                " # </weight>"
              ]
            }
          ],
          "events": [
            {
              "name": "IndexAssigned",
              "args": ["AccountId", "AccountIndex"],
              "documentation": [" A account index was assigned. \\[who, index\\]"]
            },
            {
              "name": "IndexFreed",
              "args": ["AccountIndex"],
              "documentation": [" A account index has been freed up (unassigned). \\[index\\]"]
            },
            {
              "name": "IndexFrozen",
              "args": ["AccountIndex", "AccountId"],
              "documentation": [
                " A account index has been frozen to its current account ID. \\[who, index\\]"
              ]
            }
          ],
          "constants": [
            {
              "name": "Deposit",
              "type": "BalanceOf",
              "value": "0x00407a10f35a00000000000000000000",
              "documentation": [" The deposit needed for reserving an index."]
            }
          ],
          "errors": [],
          "index": 5
        },
        {
          "name": "Balances",
          "storage": {
            "prefix": "Balances",
            "items": [
              {
                "name": "TotalIssuance",
                "modifier": "Default",
                "type": {"Plain": "Balance"},
                "fallback": "0x00000000000000000000000000000000",
                "documentation": [" The total units issued in the system."]
              },
              {
                "name": "Account",
                "modifier": "Default",
                "type": {
                  "Map": {
                    "hasher": "Blake2_128Concat",
                    "key": "AccountId",
                    "value": "AccountData",
                    "linked": false
                  }
                },
                "fallback":
                    "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
                "documentation": [
                  " The balance of an account.",
                  "",
                  " NOTE: This is only used in the case that this module is used to store balances."
                ]
              },
              {
                "name": "Locks",
                "modifier": "Default",
                "type": {
                  "Map": {
                    "hasher": "Blake2_128Concat",
                    "key": "AccountId",
                    "value": "Vec<BalanceLock>",
                    "linked": false
                  }
                },
                "fallback": "0x00",
                "documentation": [
                  " Any liquidity locks on some account balances.",
                  " NOTE: Should only be accessed when setting, changing and freeing a lock."
                ]
              },
              {
                "name": "StorageVersion",
                "modifier": "Default",
                "type": {"Plain": "Releases"},
                "fallback": "0x00",
                "documentation": [
                  " Storage version of the pallet.",
                  "",
                  " This is set to v2.0.0 for new networks."
                ]
              }
            ]
          },
          "calls": [
            {
              "name": "transfer",
              "args": [
                {"name": "dest", "type": "LookupSource"},
                {"name": "value", "type": "Compact<Balance>"}
              ],
              "documentation": [
                " Transfer some liquid free balance to another account.",
                "",
                " `transfer` will set the `FreeBalance` of the sender and receiver.",
                " It will decrease the total issuance of the system by the `TransferFee`.",
                " If the sender's account is below the existential deposit as a result",
                " of the transfer, the account will be reaped.",
                "",
                " The dispatch origin for this call must be `Signed` by the transactor.",
                "",
                " # <weight>",
                " - Dependent on arguments but not critical, given proper implementations for",
                "   input config types. See related functions below.",
                " - It contains a limited number of reads and writes internally and no complex computation.",
                "",
                " Related functions:",
                "",
                "   - `ensure_can_withdraw` is always called internally but has a bounded complexity.",
                "   - Transferring balances to accounts that did not exist before will cause",
                "      `T::OnNewAccount::on_new_account` to be called.",
                "   - Removing enough funds from an account will trigger `T::DustRemoval::on_unbalanced`.",
                "   - `transfer_keep_alive` works the same way as `transfer`, but has an additional",
                "     check that the transfer will not kill the origin account.",
                " ---------------------------------",
                " - Base Weight: 73.64 µs, worst case scenario (account created, account removed)",
                " - DB Weight: 1 Read and 1 Write to destination account",
                " - Origin account is already in memory, so no DB operations for them.",
                " # </weight>"
              ]
            },
            {
              "name": "set_balance",
              "args": [
                {"name": "who", "type": "LookupSource"},
                {"name": "new_free", "type": "Compact<Balance>"},
                {"name": "new_reserved", "type": "Compact<Balance>"}
              ],
              "documentation": [
                " Set the balances of a given account.",
                "",
                " This will alter `FreeBalance` and `ReservedBalance` in storage. it will",
                " also decrease the total issuance of the system (`TotalIssuance`).",
                " If the new free or reserved balance is below the existential deposit,",
                " it will reset the account nonce (`frame_system::AccountNonce`).",
                "",
                " The dispatch origin for this call is `root`.",
                "",
                " # <weight>",
                " - Independent of the arguments.",
                " - Contains a limited number of reads and writes.",
                " ---------------------",
                " - Base Weight:",
                "     - Creating: 27.56 µs",
                "     - Killing: 35.11 µs",
                " - DB Weight: 1 Read, 1 Write to `who`",
                " # </weight>"
              ]
            },
            {
              "name": "force_transfer",
              "args": [
                {"name": "source", "type": "LookupSource"},
                {"name": "dest", "type": "LookupSource"},
                {"name": "value", "type": "Compact<Balance>"}
              ],
              "documentation": [
                " Exactly as `transfer`, except the origin must be root and the source account may be",
                " specified.",
                " # <weight>",
                " - Same as transfer, but additional read and write because the source account is",
                "   not assumed to be in the overlay.",
                " # </weight>"
              ]
            },
            {
              "name": "transfer_keep_alive",
              "args": [
                {"name": "dest", "type": "LookupSource"},
                {"name": "value", "type": "Compact<Balance>"}
              ],
              "documentation": [
                " Same as the [`transfer`] call, but with a check that the transfer will not kill the",
                " origin account.",
                "",
                " 99% of the time you want [`transfer`] instead.",
                "",
                " [`transfer`]: struct.Module.html#method.transfer",
                " # <weight>",
                " - Cheaper than transfer because account cannot be killed.",
                " - Base Weight: 51.4 µs",
                " - DB Weight: 1 Read and 1 Write to dest (sender is in overlay already)",
                " #</weight>"
              ]
            }
          ],
          "events": [
            {
              "name": "Endowed",
              "args": ["AccountId", "Balance"],
              "documentation": [
                " An account was created with some free balance. \\[account, free_balance\\]"
              ]
            },
            {
              "name": "DustLost",
              "args": ["AccountId", "Balance"],
              "documentation": [
                " An account was removed whose balance was non-zero but below ExistentialDeposit,",
                " resulting in an outright loss. \\[account, balance\\]"
              ]
            },
            {
              "name": "Transfer",
              "args": ["AccountId", "AccountId", "Balance"],
              "documentation": [" Transfer succeeded. \\[from, to, value\\]"]
            },
            {
              "name": "BalanceSet",
              "args": ["AccountId", "Balance", "Balance"],
              "documentation": [" A balance was set by root. \\[who, free, reserved\\]"]
            },
            {
              "name": "Deposit",
              "args": ["AccountId", "Balance"],
              "documentation": [
                " Some amount was deposited (e.g. for transaction fees). \\[who, deposit\\]"
              ]
            },
            {
              "name": "Reserved",
              "args": ["AccountId", "Balance"],
              "documentation": [
                " Some balance was reserved (moved from free to reserved). \\[who, value\\]"
              ]
            },
            {
              "name": "Unreserved",
              "args": ["AccountId", "Balance"],
              "documentation": [
                " Some balance was unreserved (moved from reserved to free). \\[who, value\\]"
              ]
            },
            {
              "name": "ReserveRepatriated",
              "args": ["AccountId", "AccountId", "Balance", "BalanceStatus"],
              "documentation": [
                " Some balance was moved from the reserve of the first account to the second account.",
                " Final argument indicates the destination balance type.",
                " \\[from, to, balance, destination_status\\]"
              ]
            }
          ],
          "constants": [
            {
              "name": "ExistentialDeposit",
              "type": "Balance",
              "value": "0x00407a10f35a00000000000000000000",
              "documentation": [" The minimum amount required to keep an account open."]
            }
          ],
          "errors": [
            {
              "name": "VestingBalance",
              "documentation": [" Vesting balance too high to send value"]
            },
            {
              "name": "LiquidityRestrictions",
              "documentation": [" Account liquidity restrictions prevent withdrawal"]
            },
            {
              "name": "Overflow",
              "documentation": [" Got an overflow after adding"]
            },
            {
              "name": "InsufficientBalance",
              "documentation": [" Balance too low to send value"]
            },
            {
              "name": "ExistentialDeposit",
              "documentation": [" Value too low to create account due to existential deposit"]
            },
            {
              "name": "KeepAlive",
              "documentation": [" Transfer/payment would kill account"]
            },
            {
              "name": "ExistingVestingSchedule",
              "documentation": [" A vesting schedule already exists for this account"]
            },
            {
              "name": "DeadAccount",
              "documentation": [" Beneficiary account must pre-exist"]
            }
          ],
          "index": 6
        },
        {
          "name": "TransactionPayment",
          "storage": {
            "prefix": "TransactionPayment",
            "items": [
              {
                "name": "NextFeeMultiplier",
                "modifier": "Default",
                "type": {"Plain": "Multiplier"},
                "fallback": "0x000064a7b3b6e00d0000000000000000",
                "documentation": []
              },
              {
                "name": "StorageVersion",
                "modifier": "Default",
                "type": {"Plain": "Releases"},
                "fallback": "0x00",
                "documentation": []
              }
            ]
          },
          "calls": null,
          "events": null,
          "constants": [
            {
              "name": "TransactionByteFee",
              "type": "BalanceOf",
              "value": "0x00e40b54020000000000000000000000",
              "documentation": [
                " The fee to be paid for making a transaction; the per-byte portion."
              ]
            },
            {
              "name": "WeightToFee",
              "type": "Vec<WeightToFeeCoefficient>",
              "value": "0x0401000000000000000000000000000000000000000001",
              "documentation": [
                " The polynomial that is applied in order to derive fee from weight."
              ]
            }
          ],
          "errors": [],
          "index": 7
        },
        {
          "name": "Staking",
          "storage": {
            "prefix": "Staking",
            "items": [
              {
                "name": "HistoryDepth",
                "modifier": "Default",
                "type": {"Plain": "u32"},
                "fallback": "0x54000000",
                "documentation": [
                  " Number of eras to keep in history.",
                  "",
                  " Information is kept for eras in `[current_era - history_depth; current_era]`.",
                  "",
                  " Must be more than the number of eras delayed by session otherwise. I.e. active era must",
                  " always be in history. I.e. `active_era > current_era - history_depth` must be",
                  " guaranteed."
                ]
              },
              {
                "name": "ValidatorCount",
                "modifier": "Default",
                "type": {"Plain": "u32"},
                "fallback": "0x00000000",
                "documentation": [" The ideal number of staking participants."]
              },
              {
                "name": "MinimumValidatorCount",
                "modifier": "Default",
                "type": {"Plain": "u32"},
                "fallback": "0x00000000",
                "documentation": [
                  " Minimum number of staking participants before emergency conditions are imposed."
                ]
              },
              {
                "name": "Invulnerables",
                "modifier": "Default",
                "type": {"Plain": "Vec<AccountId>"},
                "fallback": "0x00",
                "documentation": [
                  " Any validators that may never be slashed or forcibly kicked. It's a Vec since they're",
                  " easy to initialize and the performance hit is minimal (we expect no more than four",
                  " invulnerables) and restricted to testnets."
                ]
              },
              {
                "name": "Bonded",
                "modifier": "Optional",
                "type": {
                  "Map": {
                    "hasher": "Twox64Concat",
                    "key": "AccountId",
                    "value": "AccountId",
                    "linked": false
                  }
                },
                "fallback": "0x00",
                "documentation": [
                  " Map from all locked \"stash\" accounts to the controller account."
                ]
              },
              {
                "name": "Ledger",
                "modifier": "Optional",
                "type": {
                  "Map": {
                    "hasher": "Blake2_128Concat",
                    "key": "AccountId",
                    "value": "StakingLedger",
                    "linked": false
                  }
                },
                "fallback": "0x00",
                "documentation": [
                  " Map from all (unlocked) \"controller\" accounts to the info regarding the staking."
                ]
              },
              {
                "name": "Payee",
                "modifier": "Default",
                "type": {
                  "Map": {
                    "hasher": "Twox64Concat",
                    "key": "AccountId",
                    "value": "RewardDestination",
                    "linked": false
                  }
                },
                "fallback": "0x00",
                "documentation": [" Where the reward payment should be made. Keyed by stash."]
              },
              {
                "name": "Validators",
                "modifier": "Default",
                "type": {
                  "Map": {
                    "hasher": "Twox64Concat",
                    "key": "AccountId",
                    "value": "ValidatorPrefs",
                    "linked": false
                  }
                },
                "fallback": "0x00",
                "documentation": [
                  " The map from (wannabe) validator stash key to the preferences of that validator."
                ]
              },
              {
                "name": "Nominators",
                "modifier": "Optional",
                "type": {
                  "Map": {
                    "hasher": "Twox64Concat",
                    "key": "AccountId",
                    "value": "Nominations",
                    "linked": false
                  }
                },
                "fallback": "0x00",
                "documentation": [
                  " The map from nominator stash key to the set of stash keys of all validators to nominate."
                ]
              },
              {
                "name": "CurrentEra",
                "modifier": "Optional",
                "type": {"Plain": "EraIndex"},
                "fallback": "0x00",
                "documentation": [
                  " The current era index.",
                  "",
                  " This is the latest planned era, depending on how the Session pallet queues the validator",
                  " set, it might be active or not."
                ]
              },
              {
                "name": "ActiveEra",
                "modifier": "Optional",
                "type": {"Plain": "ActiveEraInfo"},
                "fallback": "0x00",
                "documentation": [
                  " The active era information, it holds index and start.",
                  "",
                  " The active era is the era currently rewarded.",
                  " Validator set of this era must be equal to `SessionInterface::validators`."
                ]
              },
              {
                "name": "ErasStartSessionIndex",
                "modifier": "Optional",
                "type": {
                  "Map": {
                    "hasher": "Twox64Concat",
                    "key": "EraIndex",
                    "value": "SessionIndex",
                    "linked": false
                  }
                },
                "fallback": "0x00",
                "documentation": [
                  " The session index at which the era start for the last `HISTORY_DEPTH` eras."
                ]
              },
              {
                "name": "ErasStakers",
                "modifier": "Default",
                "type": {
                  "DoubleMap": {
                    "hasher": "Twox64Concat",
                    "key1": "EraIndex",
                    "key2": "AccountId",
                    "value": "Exposure",
                    "key2Hasher": "Twox64Concat"
                  }
                },
                "fallback": "0x000000",
                "documentation": [
                  " Exposure of validator at era.",
                  "",
                  " This is keyed first by the era index to allow bulk deletion and then the stash account.",
                  "",
                  " Is it removed after `HISTORY_DEPTH` eras.",
                  " If stakers hasn't been set or has been removed then empty exposure is returned."
                ]
              },
              {
                "name": "ErasStakersClipped",
                "modifier": "Default",
                "type": {
                  "DoubleMap": {
                    "hasher": "Twox64Concat",
                    "key1": "EraIndex",
                    "key2": "AccountId",
                    "value": "Exposure",
                    "key2Hasher": "Twox64Concat"
                  }
                },
                "fallback": "0x000000",
                "documentation": [
                  " Clipped Exposure of validator at era.",
                  "",
                  " This is similar to [`ErasStakers`] but number of nominators exposed is reduced to the",
                  " `T::MaxNominatorRewardedPerValidator` biggest stakers.",
                  " (Note: the field `total` and `own` of the exposure remains unchanged).",
                  " This is used to limit the i/o cost for the nominator payout.",
                  "",
                  " This is keyed fist by the era index to allow bulk deletion and then the stash account.",
                  "",
                  " Is it removed after `HISTORY_DEPTH` eras.",
                  " If stakers hasn't been set or has been removed then empty exposure is returned."
                ]
              },
              {
                "name": "ErasValidatorPrefs",
                "modifier": "Default",
                "type": {
                  "DoubleMap": {
                    "hasher": "Twox64Concat",
                    "key1": "EraIndex",
                    "key2": "AccountId",
                    "value": "ValidatorPrefs",
                    "key2Hasher": "Twox64Concat"
                  }
                },
                "fallback": "0x00",
                "documentation": [
                  " Similar to `ErasStakers`, this holds the preferences of validators.",
                  "",
                  " This is keyed first by the era index to allow bulk deletion and then the stash account.",
                  "",
                  " Is it removed after `HISTORY_DEPTH` eras."
                ]
              },
              {
                "name": "ErasValidatorReward",
                "modifier": "Optional",
                "type": {
                  "Map": {
                    "hasher": "Twox64Concat",
                    "key": "EraIndex",
                    "value": "BalanceOf",
                    "linked": false
                  }
                },
                "fallback": "0x00",
                "documentation": [
                  " The total validator era payout for the last `HISTORY_DEPTH` eras.",
                  "",
                  " Eras that haven't finished yet or has been removed doesn't have reward."
                ]
              },
              {
                "name": "ErasRewardPoints",
                "modifier": "Default",
                "type": {
                  "Map": {
                    "hasher": "Twox64Concat",
                    "key": "EraIndex",
                    "value": "EraRewardPoints",
                    "linked": false
                  }
                },
                "fallback": "0x0000000000",
                "documentation": [
                  " Rewards for the last `HISTORY_DEPTH` eras.",
                  " If reward hasn't been set or has been removed then 0 reward is returned."
                ]
              },
              {
                "name": "ErasTotalStake",
                "modifier": "Default",
                "type": {
                  "Map": {
                    "hasher": "Twox64Concat",
                    "key": "EraIndex",
                    "value": "BalanceOf",
                    "linked": false
                  }
                },
                "fallback": "0x00000000000000000000000000000000",
                "documentation": [
                  " The total amount staked for the last `HISTORY_DEPTH` eras.",
                  " If total hasn't been set or has been removed then 0 stake is returned."
                ]
              },
              {
                "name": "ForceEra",
                "modifier": "Default",
                "type": {"Plain": "Forcing"},
                "fallback": "0x00",
                "documentation": [" Mode of era forcing."]
              },
              {
                "name": "SlashRewardFraction",
                "modifier": "Default",
                "type": {"Plain": "Perbill"},
                "fallback": "0x00000000",
                "documentation": [
                  " The percentage of the slash that is distributed to reporters.",
                  "",
                  " The rest of the slashed value is handled by the `Slash`."
                ]
              },
              {
                "name": "CanceledSlashPayout",
                "modifier": "Default",
                "type": {"Plain": "BalanceOf"},
                "fallback": "0x00000000000000000000000000000000",
                "documentation": [
                  " The amount of currency given to reporters of a slash event which was",
                  " canceled by extraordinary circumstances (e.g. governance)."
                ]
              },
              {
                "name": "UnappliedSlashes",
                "modifier": "Default",
                "type": {
                  "Map": {
                    "hasher": "Twox64Concat",
                    "key": "EraIndex",
                    "value": "Vec<UnappliedSlash>",
                    "linked": false
                  }
                },
                "fallback": "0x00",
                "documentation": [" All unapplied slashes that are queued for later."]
              },
              {
                "name": "BondedEras",
                "modifier": "Default",
                "type": {"Plain": "Vec<(EraIndex,SessionIndex)>"},
                "fallback": "0x00",
                "documentation": [
                  " A mapping from still-bonded eras to the first session index of that era.",
                  "",
                  " Must contains information for eras for the range:",
                  " `[active_era - bounding_duration; active_era]`"
                ]
              },
              {
                "name": "ValidatorSlashInEra",
                "modifier": "Optional",
                "type": {
                  "DoubleMap": {
                    "hasher": "Twox64Concat",
                    "key1": "EraIndex",
                    "key2": "AccountId",
                    "value": "(Perbill,BalanceOf)",
                    "key2Hasher": "Twox64Concat"
                  }
                },
                "fallback": "0x00",
                "documentation": [
                  " All slashing events on validators, mapped by era to the highest slash proportion",
                  " and slash value of the era."
                ]
              },
              {
                "name": "NominatorSlashInEra",
                "modifier": "Optional",
                "type": {
                  "DoubleMap": {
                    "hasher": "Twox64Concat",
                    "key1": "EraIndex",
                    "key2": "AccountId",
                    "value": "BalanceOf",
                    "key2Hasher": "Twox64Concat"
                  }
                },
                "fallback": "0x00",
                "documentation": [
                  " All slashing events on nominators, mapped by era to the highest slash value of the era."
                ]
              },
              {
                "name": "SlashingSpans",
                "modifier": "Optional",
                "type": {
                  "Map": {
                    "hasher": "Twox64Concat",
                    "key": "AccountId",
                    "value": "SlashingSpans",
                    "linked": false
                  }
                },
                "fallback": "0x00",
                "documentation": [" Slashing spans for stash accounts."]
              },
              {
                "name": "SpanSlash",
                "modifier": "Default",
                "type": {
                  "Map": {
                    "hasher": "Twox64Concat",
                    "key": "(AccountId,SpanIndex)",
                    "value": "SpanRecord",
                    "linked": false
                  }
                },
                "fallback": "0x0000000000000000000000000000000000000000000000000000000000000000",
                "documentation": [
                  " Records information about the maximum slash of a stash within a slashing span,",
                  " as well as how much reward has been paid out."
                ]
              },
              {
                "name": "EarliestUnappliedSlash",
                "modifier": "Optional",
                "type": {"Plain": "EraIndex"},
                "fallback": "0x00",
                "documentation": [" The earliest era for which we have a pending, unapplied slash."]
              },
              {
                "name": "SnapshotValidators",
                "modifier": "Optional",
                "type": {"Plain": "Vec<AccountId>"},
                "fallback": "0x00",
                "documentation": [
                  " Snapshot of validators at the beginning of the current election window. This should only",
                  " have a value when [`EraElectionStatus`] == `ElectionStatus::Open(_)`."
                ]
              },
              {
                "name": "SnapshotNominators",
                "modifier": "Optional",
                "type": {"Plain": "Vec<AccountId>"},
                "fallback": "0x00",
                "documentation": [
                  " Snapshot of nominators at the beginning of the current election window. This should only",
                  " have a value when [`EraElectionStatus`] == `ElectionStatus::Open(_)`."
                ]
              },
              {
                "name": "QueuedElected",
                "modifier": "Optional",
                "type": {"Plain": "ElectionResult"},
                "fallback": "0x00",
                "documentation": [
                  " The next validator set. At the end of an era, if this is available (potentially from the",
                  " result of an offchain worker), it is immediately used. Otherwise, the on-chain election",
                  " is executed."
                ]
              },
              {
                "name": "QueuedScore",
                "modifier": "Optional",
                "type": {"Plain": "ElectionScore"},
                "fallback": "0x00",
                "documentation": [" The score of the current [`QueuedElected`]."]
              },
              {
                "name": "EraElectionStatus",
                "modifier": "Default",
                "type": {"Plain": "ElectionStatus"},
                "fallback": "0x00",
                "documentation": [
                  " Flag to control the execution of the offchain election. When `Open(_)`, we accept",
                  " solutions to be submitted."
                ]
              },
              {
                "name": "IsCurrentSessionFinal",
                "modifier": "Default",
                "type": {"Plain": "bool"},
                "fallback": "0x00",
                "documentation": [
                  " True if the current **planned** session is final. Note that this does not take era",
                  " forcing into account."
                ]
              },
              {
                "name": "StorageVersion",
                "modifier": "Default",
                "type": {"Plain": "Releases"},
                "fallback": "0x03",
                "documentation": [
                  " True if network has been upgraded to this version.",
                  " Storage version of the pallet.",
                  "",
                  " This is set to v3.0.0 for new networks."
                ]
              }
            ]
          },
          "calls": [
            {
              "name": "bond",
              "args": [
                {"name": "controller", "type": "LookupSource"},
                {"name": "value", "type": "Compact<BalanceOf>"},
                {"name": "payee", "type": "RewardDestination"}
              ],
              "documentation": [
                " Take the origin account as a stash and lock up `value` of its balance. `controller` will",
                " be the account that controls it.",
                "",
                " `value` must be more than the `minimum_balance` specified by `T::Currency`.",
                "",
                " The dispatch origin for this call must be _Signed_ by the stash account.",
                "",
                " Emits `Bonded`.",
                "",
                " # <weight>",
                " - Independent of the arguments. Moderate complexity.",
                " - O(1).",
                " - Three extra DB entries.",
                "",
                " NOTE: Two of the storage writes (`Self::bonded`, `Self::payee`) are _never_ cleaned",
                " unless the `origin` falls below _existential deposit_ and gets removed as dust.",
                " ------------------",
                " Weight: O(1)",
                " DB Weight:",
                " - Read: Bonded, Ledger, [Origin Account], Current Era, History Depth, Locks",
                " - Write: Bonded, Payee, [Origin Account], Locks, Ledger",
                " # </weight>"
              ]
            },
            {
              "name": "bond_extra",
              "args": [
                {"name": "max_additional", "type": "Compact<BalanceOf>"}
              ],
              "documentation": [
                " Add some extra amount that have appeared in the stash `free_balance` into the balance up",
                " for staking.",
                "",
                " Use this if there are additional funds in your stash account that you wish to bond.",
                " Unlike [`bond`] or [`unbond`] this function does not impose any limitation on the amount",
                " that can be added.",
                "",
                " The dispatch origin for this call must be _Signed_ by the stash, not the controller and",
                " it can be only called when [`EraElectionStatus`] is `Closed`.",
                "",
                " Emits `Bonded`.",
                "",
                " # <weight>",
                " - Independent of the arguments. Insignificant complexity.",
                " - O(1).",
                " - One DB entry.",
                " ------------",
                " DB Weight:",
                " - Read: Era Election Status, Bonded, Ledger, [Origin Account], Locks",
                " - Write: [Origin Account], Locks, Ledger",
                " # </weight>"
              ]
            },
            {
              "name": "unbond",
              "args": [
                {"name": "value", "type": "Compact<BalanceOf>"}
              ],
              "documentation": [
                " Schedule a portion of the stash to be unlocked ready for transfer out after the bond",
                " period ends. If this leaves an amount actively bonded less than",
                " T::Currency::minimum_balance(), then it is increased to the full amount.",
                "",
                " Once the unlock period is done, you can call `withdraw_unbonded` to actually move",
                " the funds out of management ready for transfer.",
                "",
                " No more than a limited number of unlocking chunks (see `MAX_UNLOCKING_CHUNKS`)",
                " can co-exists at the same time. In that case, [`Call::withdraw_unbonded`] need",
                " to be called first to remove some of the chunks (if possible).",
                "",
                " The dispatch origin for this call must be _Signed_ by the controller, not the stash.",
                " And, it can be only called when [`EraElectionStatus`] is `Closed`.",
                "",
                " Emits `Unbonded`.",
                "",
                " See also [`Call::withdraw_unbonded`].",
                "",
                " # <weight>",
                " - Independent of the arguments. Limited but potentially exploitable complexity.",
                " - Contains a limited number of reads.",
                " - Each call (requires the remainder of the bonded balance to be above `minimum_balance`)",
                "   will cause a new entry to be inserted into a vector (`Ledger.unlocking`) kept in storage.",
                "   The only way to clean the aforementioned storage item is also user-controlled via",
                "   `withdraw_unbonded`.",
                " - One DB entry.",
                " ----------",
                " Weight: O(1)",
                " DB Weight:",
                " - Read: EraElectionStatus, Ledger, CurrentEra, Locks, BalanceOf Stash,",
                " - Write: Locks, Ledger, BalanceOf Stash,",
                " </weight>"
              ]
            },
            {
              "name": "withdraw_unbonded",
              "args": [
                {"name": "num_slashing_spans", "type": "u32"}
              ],
              "documentation": [
                " Remove any unlocked chunks from the `unlocking` queue from our management.",
                "",
                " This essentially frees up that balance to be used by the stash account to do",
                " whatever it wants.",
                "",
                " The dispatch origin for this call must be _Signed_ by the controller, not the stash.",
                " And, it can be only called when [`EraElectionStatus`] is `Closed`.",
                "",
                " Emits `Withdrawn`.",
                "",
                " See also [`Call::unbond`].",
                "",
                " # <weight>",
                " - Could be dependent on the `origin` argument and how much `unlocking` chunks exist.",
                "  It implies `consolidate_unlocked` which loops over `Ledger.unlocking`, which is",
                "  indirectly user-controlled. See [`unbond`] for more detail.",
                " - Contains a limited number of reads, yet the size of which could be large based on `ledger`.",
                " - Writes are limited to the `origin` account key.",
                " ---------------",
                " Complexity O(S) where S is the number of slashing spans to remove",
                " Update:",
                " - Reads: EraElectionStatus, Ledger, Current Era, Locks, [Origin Account]",
                " - Writes: [Origin Account], Locks, Ledger",
                " Kill:",
                " - Reads: EraElectionStatus, Ledger, Current Era, Bonded, Slashing Spans, [Origin",
                "   Account], Locks, BalanceOf stash",
                " - Writes: Bonded, Slashing Spans (if S > 0), Ledger, Payee, Validators, Nominators,",
                "   [Origin Account], Locks, BalanceOf stash.",
                " - Writes Each: SpanSlash * S",
                " NOTE: Weight annotation is the kill scenario, we refund otherwise.",
                " # </weight>"
              ]
            },
            {
              "name": "validate",
              "args": [
                {"name": "prefs", "type": "ValidatorPrefs"}
              ],
              "documentation": [
                " Declare the desire to validate for the origin controller.",
                "",
                " Effects will be felt at the beginning of the next era.",
                "",
                " The dispatch origin for this call must be _Signed_ by the controller, not the stash.",
                " And, it can be only called when [`EraElectionStatus`] is `Closed`.",
                "",
                " # <weight>",
                " - Independent of the arguments. Insignificant complexity.",
                " - Contains a limited number of reads.",
                " - Writes are limited to the `origin` account key.",
                " -----------",
                " Weight: O(1)",
                " DB Weight:",
                " - Read: Era Election Status, Ledger",
                " - Write: Nominators, Validators",
                " # </weight>"
              ]
            },
            {
              "name": "nominate",
              "args": [
                {"name": "targets", "type": "Vec<LookupSource>"}
              ],
              "documentation": [
                " Declare the desire to nominate `targets` for the origin controller.",
                "",
                " Effects will be felt at the beginning of the next era. This can only be called when",
                " [`EraElectionStatus`] is `Closed`.",
                "",
                " The dispatch origin for this call must be _Signed_ by the controller, not the stash.",
                " And, it can be only called when [`EraElectionStatus`] is `Closed`.",
                "",
                " # <weight>",
                " - The transaction's complexity is proportional to the size of `targets` (N)",
                " which is capped at CompactAssignments::LIMIT (MAX_NOMINATIONS).",
                " - Both the reads and writes follow a similar pattern.",
                " ---------",
                " Weight: O(N)",
                " where N is the number of targets",
                " DB Weight:",
                " - Reads: Era Election Status, Ledger, Current Era",
                " - Writes: Validators, Nominators",
                " # </weight>"
              ]
            },
            {
              "name": "chill",
              "args": [],
              "documentation": [
                " Declare no desire to either validate or nominate.",
                "",
                " Effects will be felt at the beginning of the next era.",
                "",
                " The dispatch origin for this call must be _Signed_ by the controller, not the stash.",
                " And, it can be only called when [`EraElectionStatus`] is `Closed`.",
                "",
                " # <weight>",
                " - Independent of the arguments. Insignificant complexity.",
                " - Contains one read.",
                " - Writes are limited to the `origin` account key.",
                " --------",
                " Weight: O(1)",
                " DB Weight:",
                " - Read: EraElectionStatus, Ledger",
                " - Write: Validators, Nominators",
                " # </weight>"
              ]
            },
            {
              "name": "set_payee",
              "args": [
                {"name": "payee", "type": "RewardDestination"}
              ],
              "documentation": [
                " (Re-)set the payment target for a controller.",
                "",
                " Effects will be felt at the beginning of the next era.",
                "",
                " The dispatch origin for this call must be _Signed_ by the controller, not the stash.",
                "",
                " # <weight>",
                " - Independent of the arguments. Insignificant complexity.",
                " - Contains a limited number of reads.",
                " - Writes are limited to the `origin` account key.",
                " ---------",
                " - Weight: O(1)",
                " - DB Weight:",
                "     - Read: Ledger",
                "     - Write: Payee",
                " # </weight>"
              ]
            },
            {
              "name": "set_controller",
              "args": [
                {"name": "controller", "type": "LookupSource"}
              ],
              "documentation": [
                " (Re-)set the controller of a stash.",
                "",
                " Effects will be felt at the beginning of the next era.",
                "",
                " The dispatch origin for this call must be _Signed_ by the stash, not the controller.",
                "",
                " # <weight>",
                " - Independent of the arguments. Insignificant complexity.",
                " - Contains a limited number of reads.",
                " - Writes are limited to the `origin` account key.",
                " ----------",
                " Weight: O(1)",
                " DB Weight:",
                " - Read: Bonded, Ledger New Controller, Ledger Old Controller",
                " - Write: Bonded, Ledger New Controller, Ledger Old Controller",
                " # </weight>"
              ]
            },
            {
              "name": "set_validator_count",
              "args": [
                {"name": "new", "type": "Compact<u32>"}
              ],
              "documentation": [
                " Sets the ideal number of validators.",
                "",
                " The dispatch origin must be Root.",
                "",
                " # <weight>",
                " Weight: O(1)",
                " Write: Validator Count",
                " # </weight>"
              ]
            },
            {
              "name": "increase_validator_count",
              "args": [
                {"name": "additional", "type": "Compact<u32>"}
              ],
              "documentation": [
                " Increments the ideal number of validators.",
                "",
                " The dispatch origin must be Root.",
                "",
                " # <weight>",
                " Same as [`set_validator_count`].",
                " # </weight>"
              ]
            },
            {
              "name": "scale_validator_count",
              "args": [
                {"name": "factor", "type": "Percent"}
              ],
              "documentation": [
                " Scale up the ideal number of validators by a factor.",
                "",
                " The dispatch origin must be Root.",
                "",
                " # <weight>",
                " Same as [`set_validator_count`].",
                " # </weight>"
              ]
            },
            {
              "name": "force_no_eras",
              "args": [],
              "documentation": [
                " Force there to be no new eras indefinitely.",
                "",
                " The dispatch origin must be Root.",
                "",
                " # <weight>",
                " - No arguments.",
                " - Weight: O(1)",
                " - Write: ForceEra",
                " # </weight>"
              ]
            },
            {
              "name": "force_new_era",
              "args": [],
              "documentation": [
                " Force there to be a new era at the end of the next session. After this, it will be",
                " reset to normal (non-forced) behaviour.",
                "",
                " The dispatch origin must be Root.",
                "",
                " # <weight>",
                " - No arguments.",
                " - Weight: O(1)",
                " - Write ForceEra",
                " # </weight>"
              ]
            },
            {
              "name": "set_invulnerables",
              "args": [
                {"name": "invulnerables", "type": "Vec<AccountId>"}
              ],
              "documentation": [
                " Set the validators who cannot be slashed (if any).",
                "",
                " The dispatch origin must be Root.",
                "",
                " # <weight>",
                " - O(V)",
                " - Write: Invulnerables",
                " # </weight>"
              ]
            },
            {
              "name": "force_unstake",
              "args": [
                {"name": "stash", "type": "AccountId"},
                {"name": "num_slashing_spans", "type": "u32"}
              ],
              "documentation": [
                " Force a current staker to become completely unstaked, immediately.",
                "",
                " The dispatch origin must be Root.",
                "",
                " # <weight>",
                " O(S) where S is the number of slashing spans to be removed",
                " Reads: Bonded, Slashing Spans, Account, Locks",
                " Writes: Bonded, Slashing Spans (if S > 0), Ledger, Payee, Validators, Nominators, Account, Locks",
                " Writes Each: SpanSlash * S",
                " # </weight>"
              ]
            },
            {
              "name": "force_new_era_always",
              "args": [],
              "documentation": [
                " Force there to be a new era at the end of sessions indefinitely.",
                "",
                " The dispatch origin must be Root.",
                "",
                " # <weight>",
                " - Weight: O(1)",
                " - Write: ForceEra",
                " # </weight>"
              ]
            },
            {
              "name": "cancel_deferred_slash",
              "args": [
                {"name": "era", "type": "EraIndex"},
                {"name": "slash_indices", "type": "Vec<u32>"}
              ],
              "documentation": [
                " Cancel enactment of a deferred slash.",
                "",
                " Can be called by the `T::SlashCancelOrigin`.",
                "",
                " Parameters: era and indices of the slashes for that era to kill.",
                "",
                " # <weight>",
                " Complexity: O(U + S)",
                " with U unapplied slashes weighted with U=1000",
                " and S is the number of slash indices to be canceled.",
                " - Read: Unapplied Slashes",
                " - Write: Unapplied Slashes",
                " # </weight>"
              ]
            },
            {
              "name": "payout_stakers",
              "args": [
                {"name": "validator_stash", "type": "AccountId"},
                {"name": "era", "type": "EraIndex"}
              ],
              "documentation": [
                " Pay out all the stakers behind a single validator for a single era.",
                "",
                " - `validator_stash` is the stash account of the validator. Their nominators, up to",
                "   `T::MaxNominatorRewardedPerValidator`, will also receive their rewards.",
                " - `era` may be any era between `[current_era - history_depth; current_era]`.",
                "",
                " The origin of this call must be _Signed_. Any account can call this function, even if",
                " it is not one of the stakers.",
                "",
                " This can only be called when [`EraElectionStatus`] is `Closed`.",
                "",
                " # <weight>",
                " - Time complexity: at most O(MaxNominatorRewardedPerValidator).",
                " - Contains a limited number of reads and writes.",
                " -----------",
                " N is the Number of payouts for the validator (including the validator)",
                " Weight:",
                " - Reward Destination Staked: O(N)",
                " - Reward Destination Controller (Creating): O(N)",
                " DB Weight:",
                " - Read: EraElectionStatus, CurrentEra, HistoryDepth, ErasValidatorReward,",
                "         ErasStakersClipped, ErasRewardPoints, ErasValidatorPrefs (8 items)",
                " - Read Each: Bonded, Ledger, Payee, Locks, System Account (5 items)",
                " - Write Each: System Account, Locks, Ledger (3 items)",
                "",
                "   NOTE: weights are assuming that payouts are made to alive stash account (Staked).",
                "   Paying even a dead controller is cheaper weight-wise. We don't do any refunds here.",
                " # </weight>"
              ]
            },
            {
              "name": "rebond",
              "args": [
                {"name": "value", "type": "Compact<BalanceOf>"}
              ],
              "documentation": [
                " Rebond a portion of the stash scheduled to be unlocked.",
                "",
                " The dispatch origin must be signed by the controller, and it can be only called when",
                " [`EraElectionStatus`] is `Closed`.",
                "",
                " # <weight>",
                " - Time complexity: O(L), where L is unlocking chunks",
                " - Bounded by `MAX_UNLOCKING_CHUNKS`.",
                " - Storage changes: Can't increase storage, only decrease it.",
                " ---------------",
                " - DB Weight:",
                "     - Reads: EraElectionStatus, Ledger, Locks, [Origin Account]",
                "     - Writes: [Origin Account], Locks, Ledger",
                " # </weight>"
              ]
            },
            {
              "name": "set_history_depth",
              "args": [
                {"name": "new_history_depth", "type": "Compact<EraIndex>"},
                {"name": "_era_items_deleted", "type": "Compact<u32>"}
              ],
              "documentation": [
                " Set `HistoryDepth` value. This function will delete any history information",
                " when `HistoryDepth` is reduced.",
                "",
                " Parameters:",
                " - `new_history_depth`: The new history depth you would like to set.",
                " - `era_items_deleted`: The number of items that will be deleted by this dispatch.",
                "    This should report all the storage items that will be deleted by clearing old",
                "    era history. Needed to report an accurate weight for the dispatch. Trusted by",
                "    `Root` to report an accurate number.",
                "",
                " Origin must be root.",
                "",
                " # <weight>",
                " - E: Number of history depths removed, i.e. 10 -> 7 = 3",
                " - Weight: O(E)",
                " - DB Weight:",
                "     - Reads: Current Era, History Depth",
                "     - Writes: History Depth",
                "     - Clear Prefix Each: Era Stakers, EraStakersClipped, ErasValidatorPrefs",
                "     - Writes Each: ErasValidatorReward, ErasRewardPoints, ErasTotalStake, ErasStartSessionIndex",
                " # </weight>"
              ]
            },
            {
              "name": "reap_stash",
              "args": [
                {"name": "stash", "type": "AccountId"},
                {"name": "num_slashing_spans", "type": "u32"}
              ],
              "documentation": [
                " Remove all data structure concerning a staker/stash once its balance is zero.",
                " This is essentially equivalent to `withdraw_unbonded` except it can be called by anyone",
                " and the target `stash` must have no funds left.",
                "",
                " This can be called from any origin.",
                "",
                " - `stash`: The stash account to reap. Its balance must be zero.",
                "",
                " # <weight>",
                " Complexity: O(S) where S is the number of slashing spans on the account.",
                " DB Weight:",
                " - Reads: Stash Account, Bonded, Slashing Spans, Locks",
                " - Writes: Bonded, Slashing Spans (if S > 0), Ledger, Payee, Validators, Nominators, Stash Account, Locks",
                " - Writes Each: SpanSlash * S",
                " # </weight>"
              ]
            },
            {
              "name": "submit_election_solution",
              "args": [
                {"name": "winners", "type": "Vec<ValidatorIndex>"},
                {"name": "compact", "type": "CompactAssignments"},
                {"name": "score", "type": "ElectionScore"},
                {"name": "era", "type": "EraIndex"},
                {"name": "size", "type": "ElectionSize"}
              ],
              "documentation": [
                " Submit an election result to the chain. If the solution:",
                "",
                " 1. is valid.",
                " 2. has a better score than a potentially existing solution on chain.",
                "",
                " then, it will be _put_ on chain.",
                "",
                " A solution consists of two pieces of data:",
                "",
                " 1. `winners`: a flat vector of all the winners of the round.",
                " 2. `assignments`: the compact version of an assignment vector that encodes the edge",
                "    weights.",
                "",
                " Both of which may be computed using _phragmen_, or any other algorithm.",
                "",
                " Additionally, the submitter must provide:",
                "",
                " - The `score` that they claim their solution has.",
                "",
                " Both validators and nominators will be represented by indices in the solution. The",
                " indices should respect the corresponding types ([`ValidatorIndex`] and",
                " [`NominatorIndex`]). Moreover, they should be valid when used to index into",
                " [`SnapshotValidators`] and [`SnapshotNominators`]. Any invalid index will cause the",
                " solution to be rejected. These two storage items are set during the election window and",
                " may be used to determine the indices.",
                "",
                " A solution is valid if:",
                "",
                " 0. It is submitted when [`EraElectionStatus`] is `Open`.",
                " 1. Its claimed score is equal to the score computed on-chain.",
                " 2. Presents the correct number of winners.",
                " 3. All indexes must be value according to the snapshot vectors. All edge values must",
                "    also be correct and should not overflow the granularity of the ratio type (i.e. 256",
                "    or billion).",
                " 4. For each edge, all targets are actually nominated by the voter.",
                " 5. Has correct self-votes.",
                "",
                " A solutions score is consisted of 3 parameters:",
                "",
                " 1. `min { support.total }` for each support of a winner. This value should be maximized.",
                " 2. `sum { support.total }` for each support of a winner. This value should be minimized.",
                " 3. `sum { support.total^2 }` for each support of a winner. This value should be",
                "    minimized (to ensure less variance)",
                "",
                " # <weight>",
                " The transaction is assumed to be the longest path, a better solution.",
                "   - Initial solution is almost the same.",
                "   - Worse solution is retraced in pre-dispatch-checks which sets its own weight.",
                " # </weight>"
              ]
            },
            {
              "name": "submit_election_solution_unsigned",
              "args": [
                {"name": "winners", "type": "Vec<ValidatorIndex>"},
                {"name": "compact", "type": "CompactAssignments"},
                {"name": "score", "type": "ElectionScore"},
                {"name": "era", "type": "EraIndex"},
                {"name": "size", "type": "ElectionSize"}
              ],
              "documentation": [
                " Unsigned version of `submit_election_solution`.",
                "",
                " Note that this must pass the [`ValidateUnsigned`] check which only allows transactions",
                " from the local node to be included. In other words, only the block author can include a",
                " transaction in the block.",
                "",
                " # <weight>",
                " See [`submit_election_solution`].",
                " # </weight>"
              ]
            }
          ],
          "events": [
            {
              "name": "EraPayout",
              "args": ["EraIndex", "Balance", "Balance"],
              "documentation": [
                " The era payout has been set; the first balance is the validator-payout; the second is",
                " the remainder from the maximum amount of reward.",
                " \\[era_index, validator_payout, remainder\\]"
              ]
            },
            {
              "name": "Reward",
              "args": ["AccountId", "Balance"],
              "documentation": [" The staker has been rewarded by this amount. \\[stash, amount\\]"]
            },
            {
              "name": "Slash",
              "args": ["AccountId", "Balance"],
              "documentation": [
                " One validator (and its nominators) has been slashed by the given amount.",
                " \\[validator, amount\\]"
              ]
            },
            {
              "name": "OldSlashingReportDiscarded",
              "args": ["SessionIndex"],
              "documentation": [
                " An old slashing report from a prior era was discarded because it could",
                " not be processed. \\[session_index\\]"
              ]
            },
            {
              "name": "StakingElection",
              "args": ["ElectionCompute"],
              "documentation": [" A new set of stakers was elected with the given \\[compute\\]."]
            },
            {
              "name": "SolutionStored",
              "args": ["ElectionCompute"],
              "documentation": [
                " A new solution for the upcoming election has been stored. \\[compute\\]"
              ]
            },
            {
              "name": "Bonded",
              "args": ["AccountId", "Balance"],
              "documentation": [
                " An account has bonded this amount. \\[stash, amount\\]",
                "",
                " NOTE: This event is only emitted when funds are bonded via a dispatchable. Notably,",
                " it will not be emitted for staking rewards when they are added to stake."
              ]
            },
            {
              "name": "Unbonded",
              "args": ["AccountId", "Balance"],
              "documentation": [" An account has unbonded this amount. \\[stash, amount\\]"]
            },
            {
              "name": "Withdrawn",
              "args": ["AccountId", "Balance"],
              "documentation": [
                " An account has called `withdraw_unbonded` and removed unbonding chunks worth `Balance`",
                " from the unlocking queue. \\[stash, amount\\]"
              ]
            }
          ],
          "constants": [
            {
              "name": "SessionsPerEra",
              "type": "SessionIndex",
              "value": "0x06000000",
              "documentation": [" Number of sessions per era."]
            },
            {
              "name": "BondingDuration",
              "type": "EraIndex",
              "value": "0xa0020000",
              "documentation": [" Number of eras that staked funds must remain bonded for."]
            },
            {
              "name": "SlashDeferDuration",
              "type": "EraIndex",
              "value": "0xa8000000",
              "documentation": [
                " Number of eras that slashes are deferred by, after computation.",
                "",
                " This should be less than the bonding duration.",
                " Set to 0 if slashes should be applied immediately, without opportunity for",
                " intervention."
              ]
            },
            {
              "name": "ElectionLookahead",
              "type": "BlockNumber",
              "value": "0x32000000",
              "documentation": [
                " The number of blocks before the end of the era from which election submissions are allowed.",
                "",
                " Setting this to zero will disable the offchain compute and only on-chain seq-phragmen will",
                " be used.",
                "",
                " This is bounded by being within the last session. Hence, setting it to a value more than the",
                " length of a session will be pointless."
              ]
            },
            {
              "name": "MaxIterations",
              "type": "u32",
              "value": "0x0a000000",
              "documentation": [
                " Maximum number of balancing iterations to run in the offchain submission.",
                "",
                " If set to 0, balance_solution will not be executed at all."
              ]
            },
            {
              "name": "MinSolutionScoreBump",
              "type": "Perbill",
              "value": "0x20a10700",
              "documentation": [
                " The threshold of improvement that should be provided for a new solution to be accepted."
              ]
            },
            {
              "name": "MaxNominatorRewardedPerValidator",
              "type": "u32",
              "value": "0x00010000",
              "documentation": [
                " The maximum number of nominators rewarded for each validator.",
                "",
                " For each validator only the `MaxNominatorRewardedPerValidator` biggest stakers can claim",
                " their reward. This used to limit the i/o cost for the nominator payout."
              ]
            }
          ],
          "errors": [
            {
              "name": "NotController",
              "documentation": [" Not a controller account."]
            },
            {
              "name": "NotStash",
              "documentation": [" Not a stash account."]
            },
            {
              "name": "AlreadyBonded",
              "documentation": [" Stash is already bonded."]
            },
            {
              "name": "AlreadyPaired",
              "documentation": [" Controller is already paired."]
            },
            {
              "name": "EmptyTargets",
              "documentation": [" Targets cannot be empty."]
            },
            {
              "name": "DuplicateIndex",
              "documentation": [" Duplicate index."]
            },
            {
              "name": "InvalidSlashIndex",
              "documentation": [" Slash record index out of bounds."]
            },
            {
              "name": "InsufficientValue",
              "documentation": [" Can not bond with value less than minimum balance."]
            },
            {
              "name": "NoMoreChunks",
              "documentation": [" Can not schedule more unlock chunks."]
            },
            {
              "name": "NoUnlockChunk",
              "documentation": [" Can not rebond without unlocking chunks."]
            },
            {
              "name": "FundedTarget",
              "documentation": [" Attempting to target a stash that still has funds."]
            },
            {
              "name": "InvalidEraToReward",
              "documentation": [" Invalid era to reward."]
            },
            {
              "name": "InvalidNumberOfNominations",
              "documentation": [" Invalid number of nominations."]
            },
            {
              "name": "NotSortedAndUnique",
              "documentation": [" Items are not sorted and unique."]
            },
            {
              "name": "AlreadyClaimed",
              "documentation": [
                " Rewards for this era have already been claimed for this validator."
              ]
            },
            {
              "name": "OffchainElectionEarlySubmission",
              "documentation": [" The submitted result is received out of the open window."]
            },
            {
              "name": "OffchainElectionWeakSubmission",
              "documentation": [" The submitted result is not as good as the one stored on chain."]
            },
            {
              "name": "SnapshotUnavailable",
              "documentation": [" The snapshot data of the current window is missing."]
            },
            {
              "name": "OffchainElectionBogusWinnerCount",
              "documentation": [" Incorrect number of winners were presented."]
            },
            {
              "name": "OffchainElectionBogusWinner",
              "documentation": [
                " One of the submitted winners is not an active candidate on chain (index is out of range",
                " in snapshot)."
              ]
            },
            {
              "name": "OffchainElectionBogusCompact",
              "documentation": [
                " Error while building the assignment type from the compact. This can happen if an index",
                " is invalid, or if the weights _overflow_."
              ]
            },
            {
              "name": "OffchainElectionBogusNominator",
              "documentation": [
                " One of the submitted nominators is not an active nominator on chain."
              ]
            },
            {
              "name": "OffchainElectionBogusNomination",
              "documentation": [
                " One of the submitted nominators has an edge to which they have not voted on chain."
              ]
            },
            {
              "name": "OffchainElectionSlashedNomination",
              "documentation": [
                " One of the submitted nominators has an edge which is submitted before the last non-zero",
                " slash of the target."
              ]
            },
            {
              "name": "OffchainElectionBogusSelfVote",
              "documentation": [
                " A self vote must only be originated from a validator to ONLY themselves."
              ]
            },
            {
              "name": "OffchainElectionBogusEdge",
              "documentation": [
                " The submitted result has unknown edges that are not among the presented winners."
              ]
            },
            {
              "name": "OffchainElectionBogusScore",
              "documentation": [
                " The claimed score does not match with the one computed from the data."
              ]
            },
            {
              "name": "OffchainElectionBogusElectionSize",
              "documentation": [" The election size is invalid."]
            },
            {
              "name": "CallNotAllowed",
              "documentation": [
                " The call is not allowed at the given time due to restrictions of election period."
              ]
            },
            {
              "name": "IncorrectHistoryDepth",
              "documentation": [" Incorrect previous history depth input provided."]
            },
            {
              "name": "IncorrectSlashingSpans",
              "documentation": [" Incorrect number of slashing spans provided."]
            }
          ],
          "index": 8
        },
        {
          "name": "Session",
          "storage": {
            "prefix": "Session",
            "items": [
              {
                "name": "Validators",
                "modifier": "Default",
                "type": {"Plain": "Vec<ValidatorId>"},
                "fallback": "0x00",
                "documentation": [" The current set of validators."]
              },
              {
                "name": "CurrentIndex",
                "modifier": "Default",
                "type": {"Plain": "SessionIndex"},
                "fallback": "0x00000000",
                "documentation": [" Current index of the session."]
              },
              {
                "name": "QueuedChanged",
                "modifier": "Default",
                "type": {"Plain": "bool"},
                "fallback": "0x00",
                "documentation": [
                  " True if the underlying economic identities or weighting behind the validators",
                  " has changed in the queued validator set."
                ]
              },
              {
                "name": "QueuedKeys",
                "modifier": "Default",
                "type": {"Plain": "Vec<(ValidatorId,Keys)>"},
                "fallback": "0x00",
                "documentation": [
                  " The queued keys for the next session. When the next session begins, these keys",
                  " will be used to determine the validator's session keys."
                ]
              },
              {
                "name": "DisabledValidators",
                "modifier": "Default",
                "type": {"Plain": "Vec<u32>"},
                "fallback": "0x00",
                "documentation": [
                  " Indices of disabled validators.",
                  "",
                  " The set is cleared when `on_session_ending` returns a new set of identities."
                ]
              },
              {
                "name": "NextKeys",
                "modifier": "Optional",
                "type": {
                  "Map": {
                    "hasher": "Twox64Concat",
                    "key": "ValidatorId",
                    "value": "Keys",
                    "linked": false
                  }
                },
                "fallback": "0x00",
                "documentation": [" The next session keys for a validator."]
              },
              {
                "name": "KeyOwner",
                "modifier": "Optional",
                "type": {
                  "Map": {
                    "hasher": "Twox64Concat",
                    "key": "(KeyTypeId,Bytes)",
                    "value": "ValidatorId",
                    "linked": false
                  }
                },
                "fallback": "0x00",
                "documentation": [
                  " The owner of a key. The key is the `KeyTypeId` + the encoded key."
                ]
              }
            ]
          },
          "calls": [
            {
              "name": "set_keys",
              "args": [
                {"name": "keys", "type": "Keys"},
                {"name": "proof", "type": "Bytes"}
              ],
              "documentation": [
                " Sets the session key(s) of the function caller to `keys`.",
                " Allows an account to set its session key prior to becoming a validator.",
                " This doesn't take effect until the next session.",
                "",
                " The dispatch origin of this function must be signed.",
                "",
                " # <weight>",
                " - Complexity: `O(1)`",
                "   Actual cost depends on the number of length of `T::Keys::key_ids()` which is fixed.",
                " - DbReads: `origin account`, `T::ValidatorIdOf`, `NextKeys`",
                " - DbWrites: `origin account`, `NextKeys`",
                " - DbReads per key id: `KeyOwner`",
                " - DbWrites per key id: `KeyOwner`",
                " # </weight>"
              ]
            },
            {
              "name": "purge_keys",
              "args": [],
              "documentation": [
                " Removes any session key(s) of the function caller.",
                " This doesn't take effect until the next session.",
                "",
                " The dispatch origin of this function must be signed.",
                "",
                " # <weight>",
                " - Complexity: `O(1)` in number of key types.",
                "   Actual cost depends on the number of length of `T::Keys::key_ids()` which is fixed.",
                " - DbReads: `T::ValidatorIdOf`, `NextKeys`, `origin account`",
                " - DbWrites: `NextKeys`, `origin account`",
                " - DbWrites per key id: `KeyOwnder`",
                " # </weight>"
              ]
            }
          ],
          "events": [
            {
              "name": "NewSession",
              "args": ["SessionIndex"],
              "documentation": [
                " New session has happened. Note that the argument is the \\[session_index\\], not the block",
                " number as the type might suggest."
              ]
            }
          ],
          "constants": [],
          "errors": [
            {
              "name": "InvalidProof",
              "documentation": [" Invalid ownership proof."]
            },
            {
              "name": "NoAssociatedValidatorId",
              "documentation": [" No associated validator ID for account."]
            },
            {
              "name": "DuplicatedKey",
              "documentation": [" Registered duplicate key."]
            },
            {
              "name": "NoKeys",
              "documentation": [" No keys are associated with this account."]
            }
          ],
          "index": 9
        },
        {
          "name": "Democracy",
          "storage": {
            "prefix": "Democracy",
            "items": [
              {
                "name": "PublicPropCount",
                "modifier": "Default",
                "type": {"Plain": "PropIndex"},
                "fallback": "0x00000000",
                "documentation": [" The number of (public) proposals that have been made so far."]
              },
              {
                "name": "PublicProps",
                "modifier": "Default",
                "type": {"Plain": "Vec<(PropIndex,Hash,AccountId)>"},
                "fallback": "0x00",
                "documentation": [
                  " The public proposals. Unsorted. The second item is the proposal's hash."
                ]
              },
              {
                "name": "DepositOf",
                "modifier": "Optional",
                "type": {
                  "Map": {
                    "hasher": "Twox64Concat",
                    "key": "PropIndex",
                    "value": "(Vec<AccountId>,BalanceOf)",
                    "linked": false
                  }
                },
                "fallback": "0x00",
                "documentation": [
                  " Those who have locked a deposit.",
                  "",
                  " TWOX-NOTE: Safe, as increasing integer keys are safe."
                ]
              },
              {
                "name": "Preimages",
                "modifier": "Optional",
                "type": {
                  "Map": {
                    "hasher": "Identity",
                    "key": "Hash",
                    "value": "PreimageStatus",
                    "linked": false
                  }
                },
                "fallback": "0x00",
                "documentation": [
                  " Map of hashes to the proposal preimage, along with who registered it and their deposit.",
                  " The block number is the block at which it was deposited."
                ]
              },
              {
                "name": "ReferendumCount",
                "modifier": "Default",
                "type": {"Plain": "ReferendumIndex"},
                "fallback": "0x00000000",
                "documentation": [
                  " The next free referendum index, aka the number of referenda started so far."
                ]
              },
              {
                "name": "LowestUnbaked",
                "modifier": "Default",
                "type": {"Plain": "ReferendumIndex"},
                "fallback": "0x00000000",
                "documentation": [
                  " The lowest referendum index representing an unbaked referendum. Equal to",
                  " `ReferendumCount` if there isn't a unbaked referendum."
                ]
              },
              {
                "name": "ReferendumInfoOf",
                "modifier": "Optional",
                "type": {
                  "Map": {
                    "hasher": "Twox64Concat",
                    "key": "ReferendumIndex",
                    "value": "ReferendumInfo",
                    "linked": false
                  }
                },
                "fallback": "0x00",
                "documentation": [
                  " Information concerning any given referendum.",
                  "",
                  " TWOX-NOTE: SAFE as indexes are not under an attacker’s control."
                ]
              },
              {
                "name": "VotingOf",
                "modifier": "Default",
                "type": {
                  "Map": {
                    "hasher": "Twox64Concat",
                    "key": "AccountId",
                    "value": "Voting",
                    "linked": false
                  }
                },
                "fallback":
                    "0x000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
                "documentation": [
                  " All votes for a particular voter. We store the balance for the number of votes that we",
                  " have recorded. The second item is the total amount of delegations, that will be added.",
                  "",
                  " TWOX-NOTE: SAFE as `AccountId`s are crypto hashes anyway."
                ]
              },
              {
                "name": "Locks",
                "modifier": "Optional",
                "type": {
                  "Map": {
                    "hasher": "Twox64Concat",
                    "key": "AccountId",
                    "value": "BlockNumber",
                    "linked": false
                  }
                },
                "fallback": "0x00",
                "documentation": [
                  " Accounts for which there are locks in action which may be removed at some point in the",
                  " future. The value is the block number at which the lock expires and may be removed.",
                  "",
                  " TWOX-NOTE: OK ― `AccountId` is a secure hash."
                ]
              },
              {
                "name": "LastTabledWasExternal",
                "modifier": "Default",
                "type": {"Plain": "bool"},
                "fallback": "0x00",
                "documentation": [
                  " True if the last referendum tabled was submitted externally. False if it was a public",
                  " proposal."
                ]
              },
              {
                "name": "NextExternal",
                "modifier": "Optional",
                "type": {"Plain": "(Hash,VoteThreshold)"},
                "fallback": "0x00",
                "documentation": [
                  " The referendum to be tabled whenever it would be valid to table an external proposal.",
                  " This happens when a referendum needs to be tabled and one of two conditions are met:",
                  " - `LastTabledWasExternal` is `false`; or",
                  " - `PublicProps` is empty."
                ]
              },
              {
                "name": "Blacklist",
                "modifier": "Optional",
                "type": {
                  "Map": {
                    "hasher": "Identity",
                    "key": "Hash",
                    "value": "(BlockNumber,Vec<AccountId>)",
                    "linked": false
                  }
                },
                "fallback": "0x00",
                "documentation": [
                  " A record of who vetoed what. Maps proposal hash to a possible existent block number",
                  " (until when it may not be resubmitted) and who vetoed it."
                ]
              },
              {
                "name": "Cancellations",
                "modifier": "Default",
                "type": {
                  "Map": {"hasher": "Identity", "key": "Hash", "value": "bool", "linked": false}
                },
                "fallback": "0x00",
                "documentation": [
                  " Record of all proposals that have been subject to emergency cancellation."
                ]
              },
              {
                "name": "StorageVersion",
                "modifier": "Optional",
                "type": {"Plain": "Releases"},
                "fallback": "0x00",
                "documentation": [
                  " Storage version of the pallet.",
                  "",
                  " New networks start with last version."
                ]
              }
            ]
          },
          "calls": [
            {
              "name": "propose",
              "args": [
                {"name": "proposal_hash", "type": "Hash"},
                {"name": "value", "type": "Compact<BalanceOf>"}
              ],
              "documentation": [
                " Propose a sensitive action to be taken.",
                "",
                " The dispatch origin of this call must be _Signed_ and the sender must",
                " have funds to cover the deposit.",
                "",
                " - `proposal_hash`: The hash of the proposal preimage.",
                " - `value`: The amount of deposit (must be at least `MinimumDeposit`).",
                "",
                " Emits `Proposed`.",
                "",
                " Weight: `O(p)`"
              ]
            },
            {
              "name": "second",
              "args": [
                {"name": "proposal", "type": "Compact<PropIndex>"},
                {"name": "seconds_upper_bound", "type": "Compact<u32>"}
              ],
              "documentation": [
                " Signals agreement with a particular proposal.",
                "",
                " The dispatch origin of this call must be _Signed_ and the sender",
                " must have funds to cover the deposit, equal to the original deposit.",
                "",
                " - `proposal`: The index of the proposal to second.",
                " - `seconds_upper_bound`: an upper bound on the current number of seconds on this",
                "   proposal. Extrinsic is weighted according to this value with no refund.",
                "",
                " Weight: `O(S)` where S is the number of seconds a proposal already has."
              ]
            },
            {
              "name": "vote",
              "args": [
                {"name": "ref_index", "type": "Compact<ReferendumIndex>"},
                {"name": "vote", "type": "AccountVote"}
              ],
              "documentation": [
                " Vote in a referendum. If `vote.is_aye()`, the vote is to enact the proposal;",
                " otherwise it is a vote to keep the status quo.",
                "",
                " The dispatch origin of this call must be _Signed_.",
                "",
                " - `ref_index`: The index of the referendum to vote for.",
                " - `vote`: The vote configuration.",
                "",
                " Weight: `O(R)` where R is the number of referendums the voter has voted on."
              ]
            },
            {
              "name": "emergency_cancel",
              "args": [
                {"name": "ref_index", "type": "ReferendumIndex"}
              ],
              "documentation": [
                " Schedule an emergency cancellation of a referendum. Cannot happen twice to the same",
                " referendum.",
                "",
                " The dispatch origin of this call must be `CancellationOrigin`.",
                "",
                " -`ref_index`: The index of the referendum to cancel.",
                "",
                " Weight: `O(1)`."
              ]
            },
            {
              "name": "external_propose",
              "args": [
                {"name": "proposal_hash", "type": "Hash"}
              ],
              "documentation": [
                " Schedule a referendum to be tabled once it is legal to schedule an external",
                " referendum.",
                "",
                " The dispatch origin of this call must be `ExternalOrigin`.",
                "",
                " - `proposal_hash`: The preimage hash of the proposal.",
                "",
                " Weight: `O(V)` with V number of vetoers in the blacklist of proposal.",
                "   Decoding vec of length V. Charged as maximum"
              ]
            },
            {
              "name": "external_propose_majority",
              "args": [
                {"name": "proposal_hash", "type": "Hash"}
              ],
              "documentation": [
                " Schedule a majority-carries referendum to be tabled next once it is legal to schedule",
                " an external referendum.",
                "",
                " The dispatch of this call must be `ExternalMajorityOrigin`.",
                "",
                " - `proposal_hash`: The preimage hash of the proposal.",
                "",
                " Unlike `external_propose`, blacklisting has no effect on this and it may replace a",
                " pre-scheduled `external_propose` call.",
                "",
                " Weight: `O(1)`"
              ]
            },
            {
              "name": "external_propose_default",
              "args": [
                {"name": "proposal_hash", "type": "Hash"}
              ],
              "documentation": [
                " Schedule a negative-turnout-bias referendum to be tabled next once it is legal to",
                " schedule an external referendum.",
                "",
                " The dispatch of this call must be `ExternalDefaultOrigin`.",
                "",
                " - `proposal_hash`: The preimage hash of the proposal.",
                "",
                " Unlike `external_propose`, blacklisting has no effect on this and it may replace a",
                " pre-scheduled `external_propose` call.",
                "",
                " Weight: `O(1)`"
              ]
            },
            {
              "name": "fast_track",
              "args": [
                {"name": "proposal_hash", "type": "Hash"},
                {"name": "voting_period", "type": "BlockNumber"},
                {"name": "delay", "type": "BlockNumber"}
              ],
              "documentation": [
                " Schedule the currently externally-proposed majority-carries referendum to be tabled",
                " immediately. If there is no externally-proposed referendum currently, or if there is one",
                " but it is not a majority-carries referendum then it fails.",
                "",
                " The dispatch of this call must be `FastTrackOrigin`.",
                "",
                " - `proposal_hash`: The hash of the current external proposal.",
                " - `voting_period`: The period that is allowed for voting on this proposal. Increased to",
                "   `FastTrackVotingPeriod` if too low.",
                " - `delay`: The number of block after voting has ended in approval and this should be",
                "   enacted. This doesn't have a minimum amount.",
                "",
                " Emits `Started`.",
                "",
                " Weight: `O(1)`"
              ]
            },
            {
              "name": "veto_external",
              "args": [
                {"name": "proposal_hash", "type": "Hash"}
              ],
              "documentation": [
                " Veto and blacklist the external proposal hash.",
                "",
                " The dispatch origin of this call must be `VetoOrigin`.",
                "",
                " - `proposal_hash`: The preimage hash of the proposal to veto and blacklist.",
                "",
                " Emits `Vetoed`.",
                "",
                " Weight: `O(V + log(V))` where V is number of `existing vetoers`"
              ]
            },
            {
              "name": "cancel_referendum",
              "args": [
                {"name": "ref_index", "type": "Compact<ReferendumIndex>"}
              ],
              "documentation": [
                " Remove a referendum.",
                "",
                " The dispatch origin of this call must be _Root_.",
                "",
                " - `ref_index`: The index of the referendum to cancel.",
                "",
                " # Weight: `O(1)`."
              ]
            },
            {
              "name": "cancel_queued",
              "args": [
                {"name": "which", "type": "ReferendumIndex"}
              ],
              "documentation": [
                " Cancel a proposal queued for enactment.",
                "",
                " The dispatch origin of this call must be _Root_.",
                "",
                " - `which`: The index of the referendum to cancel.",
                "",
                " Weight: `O(D)` where `D` is the items in the dispatch queue. Weighted as `D = 10`."
              ]
            },
            {
              "name": "delegate",
              "args": [
                {"name": "to", "type": "AccountId"},
                {"name": "conviction", "type": "Conviction"},
                {"name": "balance", "type": "BalanceOf"}
              ],
              "documentation": [
                " Delegate the voting power (with some given conviction) of the sending account.",
                "",
                " The balance delegated is locked for as long as it's delegated, and thereafter for the",
                " time appropriate for the conviction's lock period.",
                "",
                " The dispatch origin of this call must be _Signed_, and the signing account must either:",
                "   - be delegating already; or",
                "   - have no voting activity (if there is, then it will need to be removed/consolidated",
                "     through `reap_vote` or `unvote`).",
                "",
                " - `to`: The account whose voting the `target` account's voting power will follow.",
                " - `conviction`: The conviction that will be attached to the delegated votes. When the",
                "   account is undelegated, the funds will be locked for the corresponding period.",
                " - `balance`: The amount of the account's balance to be used in delegating. This must",
                "   not be more than the account's current balance.",
                "",
                " Emits `Delegated`.",
                "",
                " Weight: `O(R)` where R is the number of referendums the voter delegating to has",
                "   voted on. Weight is charged as if maximum votes."
              ]
            },
            {
              "name": "undelegate",
              "args": [],
              "documentation": [
                " Undelegate the voting power of the sending account.",
                "",
                " Tokens may be unlocked following once an amount of time consistent with the lock period",
                " of the conviction with which the delegation was issued.",
                "",
                " The dispatch origin of this call must be _Signed_ and the signing account must be",
                " currently delegating.",
                "",
                " Emits `Undelegated`.",
                "",
                " Weight: `O(R)` where R is the number of referendums the voter delegating to has",
                "   voted on. Weight is charged as if maximum votes."
              ]
            },
            {
              "name": "clear_public_proposals",
              "args": [],
              "documentation": [
                " Clears all public proposals.",
                "",
                " The dispatch origin of this call must be _Root_.",
                "",
                " Weight: `O(1)`."
              ]
            },
            {
              "name": "note_preimage",
              "args": [
                {"name": "encoded_proposal", "type": "Bytes"}
              ],
              "documentation": [
                " Register the preimage for an upcoming proposal. This doesn't require the proposal to be",
                " in the dispatch queue but does require a deposit, returned once enacted.",
                "",
                " The dispatch origin of this call must be _Signed_.",
                "",
                " - `encoded_proposal`: The preimage of a proposal.",
                "",
                " Emits `PreimageNoted`.",
                "",
                " Weight: `O(E)` with E size of `encoded_proposal` (protected by a required deposit)."
              ]
            },
            {
              "name": "note_preimage_operational",
              "args": [
                {"name": "encoded_proposal", "type": "Bytes"}
              ],
              "documentation": [
                " Same as `note_preimage` but origin is `OperationalPreimageOrigin`."
              ]
            },
            {
              "name": "note_imminent_preimage",
              "args": [
                {"name": "encoded_proposal", "type": "Bytes"}
              ],
              "documentation": [
                " Register the preimage for an upcoming proposal. This requires the proposal to be",
                " in the dispatch queue. No deposit is needed. When this call is successful, i.e.",
                " the preimage has not been uploaded before and matches some imminent proposal,",
                " no fee is paid.",
                "",
                " The dispatch origin of this call must be _Signed_.",
                "",
                " - `encoded_proposal`: The preimage of a proposal.",
                "",
                " Emits `PreimageNoted`.",
                "",
                " Weight: `O(E)` with E size of `encoded_proposal` (protected by a required deposit)."
              ]
            },
            {
              "name": "note_imminent_preimage_operational",
              "args": [
                {"name": "encoded_proposal", "type": "Bytes"}
              ],
              "documentation": [
                " Same as `note_imminent_preimage` but origin is `OperationalPreimageOrigin`."
              ]
            },
            {
              "name": "reap_preimage",
              "args": [
                {"name": "proposal_hash", "type": "Hash"},
                {"name": "proposal_len_upper_bound", "type": "Compact<u32>"}
              ],
              "documentation": [
                " Remove an expired proposal preimage and collect the deposit.",
                "",
                " The dispatch origin of this call must be _Signed_.",
                "",
                " - `proposal_hash`: The preimage hash of a proposal.",
                " - `proposal_length_upper_bound`: an upper bound on length of the proposal.",
                "   Extrinsic is weighted according to this value with no refund.",
                "",
                " This will only work after `VotingPeriod` blocks from the time that the preimage was",
                " noted, if it's the same account doing it. If it's a different account, then it'll only",
                " work an additional `EnactmentPeriod` later.",
                "",
                " Emits `PreimageReaped`.",
                "",
                " Weight: `O(D)` where D is length of proposal."
              ]
            },
            {
              "name": "unlock",
              "args": [
                {"name": "target", "type": "AccountId"}
              ],
              "documentation": [
                " Unlock tokens that have an expired lock.",
                "",
                " The dispatch origin of this call must be _Signed_.",
                "",
                " - `target`: The account to remove the lock on.",
                "",
                " Weight: `O(R)` with R number of vote of target."
              ]
            },
            {
              "name": "remove_vote",
              "args": [
                {"name": "index", "type": "ReferendumIndex"}
              ],
              "documentation": [
                " Remove a vote for a referendum.",
                "",
                " If:",
                " - the referendum was cancelled, or",
                " - the referendum is ongoing, or",
                " - the referendum has ended such that",
                "   - the vote of the account was in opposition to the result; or",
                "   - there was no conviction to the account's vote; or",
                "   - the account made a split vote",
                " ...then the vote is removed cleanly and a following call to `unlock` may result in more",
                " funds being available.",
                "",
                " If, however, the referendum has ended and:",
                " - it finished corresponding to the vote of the account, and",
                " - the account made a standard vote with conviction, and",
                " - the lock period of the conviction is not over",
                " ...then the lock will be aggregated into the overall account's lock, which may involve",
                " *overlocking* (where the two locks are combined into a single lock that is the maximum",
                " of both the amount locked and the time is it locked for).",
                "",
                " The dispatch origin of this call must be _Signed_, and the signer must have a vote",
                " registered for referendum `index`.",
                "",
                " - `index`: The index of referendum of the vote to be removed.",
                "",
                " Weight: `O(R + log R)` where R is the number of referenda that `target` has voted on.",
                "   Weight is calculated for the maximum number of vote."
              ]
            },
            {
              "name": "remove_other_vote",
              "args": [
                {"name": "target", "type": "AccountId"},
                {"name": "index", "type": "ReferendumIndex"}
              ],
              "documentation": [
                " Remove a vote for a referendum.",
                "",
                " If the `target` is equal to the signer, then this function is exactly equivalent to",
                " `remove_vote`. If not equal to the signer, then the vote must have expired,",
                " either because the referendum was cancelled, because the voter lost the referendum or",
                " because the conviction period is over.",
                "",
                " The dispatch origin of this call must be _Signed_.",
                "",
                " - `target`: The account of the vote to be removed; this account must have voted for",
                "   referendum `index`.",
                " - `index`: The index of referendum of the vote to be removed.",
                "",
                " Weight: `O(R + log R)` where R is the number of referenda that `target` has voted on.",
                "   Weight is calculated for the maximum number of vote."
              ]
            },
            {
              "name": "enact_proposal",
              "args": [
                {"name": "proposal_hash", "type": "Hash"},
                {"name": "index", "type": "ReferendumIndex"}
              ],
              "documentation": [
                " Enact a proposal from a referendum. For now we just make the weight be the maximum."
              ]
            },
            {
              "name": "blacklist",
              "args": [
                {"name": "proposal_hash", "type": "Hash"},
                {"name": "maybe_ref_index", "type": "Option<ReferendumIndex>"}
              ],
              "documentation": [
                " Permanently place a proposal into the blacklist. This prevents it from ever being",
                " proposed again.",
                "",
                " If called on a queued public or external proposal, then this will result in it being",
                " removed. If the `ref_index` supplied is an active referendum with the proposal hash,",
                " then it will be cancelled.",
                "",
                " The dispatch origin of this call must be `BlacklistOrigin`.",
                "",
                " - `proposal_hash`: The proposal hash to blacklist permanently.",
                " - `ref_index`: An ongoing referendum whose hash is `proposal_hash`, which will be",
                " cancelled.",
                "",
                " Weight: `O(p)` (though as this is an high-privilege dispatch, we assume it has a",
                "   reasonable value)."
              ]
            },
            {
              "name": "cancel_proposal",
              "args": [
                {"name": "prop_index", "type": "Compact<PropIndex>"}
              ],
              "documentation": [
                " Remove a proposal.",
                "",
                " The dispatch origin of this call must be `CancelProposalOrigin`.",
                "",
                " - `prop_index`: The index of the proposal to cancel.",
                "",
                " Weight: `O(p)` where `p = PublicProps::<T>::decode_len()`"
              ]
            }
          ],
          "events": [
            {
              "name": "Proposed",
              "args": ["PropIndex", "Balance"],
              "documentation": [
                " A motion has been proposed by a public account. \\[proposal_index, deposit\\]"
              ]
            },
            {
              "name": "Tabled",
              "args": ["PropIndex", "Balance", "Vec<AccountId>"],
              "documentation": [
                " A public proposal has been tabled for referendum vote. \\[proposal_index, deposit, depositors\\]"
              ]
            },
            {
              "name": "ExternalTabled",
              "args": [],
              "documentation": [" An external proposal has been tabled."]
            },
            {
              "name": "Started",
              "args": ["ReferendumIndex", "VoteThreshold"],
              "documentation": [" A referendum has begun. \\[ref_index, threshold\\]"]
            },
            {
              "name": "Passed",
              "args": ["ReferendumIndex"],
              "documentation": [" A proposal has been approved by referendum. \\[ref_index\\]"]
            },
            {
              "name": "NotPassed",
              "args": ["ReferendumIndex"],
              "documentation": [" A proposal has been rejected by referendum. \\[ref_index\\]"]
            },
            {
              "name": "Cancelled",
              "args": ["ReferendumIndex"],
              "documentation": [" A referendum has been cancelled. \\[ref_index\\]"]
            },
            {
              "name": "Executed",
              "args": ["ReferendumIndex", "bool"],
              "documentation": [" A proposal has been enacted. \\[ref_index, is_ok\\]"]
            },
            {
              "name": "Delegated",
              "args": ["AccountId", "AccountId"],
              "documentation": [
                " An account has delegated their vote to another account. \\[who, target\\]"
              ]
            },
            {
              "name": "Undelegated",
              "args": ["AccountId"],
              "documentation": [" An \\[account\\] has cancelled a previous delegation operation."]
            },
            {
              "name": "Vetoed",
              "args": ["AccountId", "Hash", "BlockNumber"],
              "documentation": [
                " An external proposal has been vetoed. \\[who, proposal_hash, until\\]"
              ]
            },
            {
              "name": "PreimageNoted",
              "args": ["Hash", "AccountId", "Balance"],
              "documentation": [
                " A proposal's preimage was noted, and the deposit taken. \\[proposal_hash, who, deposit\\]"
              ]
            },
            {
              "name": "PreimageUsed",
              "args": ["Hash", "AccountId", "Balance"],
              "documentation": [
                " A proposal preimage was removed and used (the deposit was returned).",
                " \\[proposal_hash, provider, deposit\\]"
              ]
            },
            {
              "name": "PreimageInvalid",
              "args": ["Hash", "ReferendumIndex"],
              "documentation": [
                " A proposal could not be executed because its preimage was invalid.",
                " \\[proposal_hash, ref_index\\]"
              ]
            },
            {
              "name": "PreimageMissing",
              "args": ["Hash", "ReferendumIndex"],
              "documentation": [
                " A proposal could not be executed because its preimage was missing.",
                " \\[proposal_hash, ref_index\\]"
              ]
            },
            {
              "name": "PreimageReaped",
              "args": ["Hash", "AccountId", "Balance", "AccountId"],
              "documentation": [
                " A registered preimage was removed and the deposit collected by the reaper.",
                " \\[proposal_hash, provider, deposit, reaper\\]"
              ]
            },
            {
              "name": "Unlocked",
              "args": ["AccountId"],
              "documentation": [" An \\[account\\] has been unlocked successfully."]
            },
            {
              "name": "Blacklisted",
              "args": ["Hash"],
              "documentation": [" A proposal \\[hash\\] has been blacklisted permanently."]
            }
          ],
          "constants": [
            {
              "name": "EnactmentPeriod",
              "type": "BlockNumber",
              "value": "0x002f0d00",
              "documentation": [
                " The minimum period of locking and the period between a proposal being approved and enacted.",
                "",
                " It should generally be a little more than the unstake period to ensure that",
                " voting stakers have an opportunity to remove themselves from the system in the case where",
                " they are on the losing side of a vote."
              ]
            },
            {
              "name": "LaunchPeriod",
              "type": "BlockNumber",
              "value": "0x004e0c00",
              "documentation": [" How often (in blocks) new public referenda are launched."]
            },
            {
              "name": "VotingPeriod",
              "type": "BlockNumber",
              "value": "0x004e0c00",
              "documentation": [" How often (in blocks) to check for new votes."]
            },
            {
              "name": "MinimumDeposit",
              "type": "BalanceOf",
              "value": "0x0000c16ff28623000000000000000000",
              "documentation": [
                " The minimum amount to be used as a deposit for a public referendum proposal."
              ]
            },
            {
              "name": "FastTrackVotingPeriod",
              "type": "BlockNumber",
              "value": "0x80510100",
              "documentation": [" Minimum voting period allowed for an emergency referendum."]
            },
            {
              "name": "CooloffPeriod",
              "type": "BlockNumber",
              "value": "0x004e0c00",
              "documentation": [
                " Period in blocks where an external proposal may not be re-submitted after being vetoed."
              ]
            },
            {
              "name": "PreimageByteDeposit",
              "type": "BalanceOf",
              "value": "0x0010a5d4e80000000000000000000000",
              "documentation": [
                " The amount of balance that must be deposited per byte of preimage stored."
              ]
            },
            {
              "name": "MaxVotes",
              "type": "u32",
              "value": "0x64000000",
              "documentation": [" The maximum number of votes for an account."]
            }
          ],
          "errors": [
            {
              "name": "ValueLow",
              "documentation": [" Value too low"]
            },
            {
              "name": "ProposalMissing",
              "documentation": [" Proposal does not exist"]
            },
            {
              "name": "BadIndex",
              "documentation": [" Unknown index"]
            },
            {
              "name": "AlreadyCanceled",
              "documentation": [" Cannot cancel the same proposal twice"]
            },
            {
              "name": "DuplicateProposal",
              "documentation": [" Proposal already made"]
            },
            {
              "name": "ProposalBlacklisted",
              "documentation": [" Proposal still blacklisted"]
            },
            {
              "name": "NotSimpleMajority",
              "documentation": [" Next external proposal not simple majority"]
            },
            {
              "name": "InvalidHash",
              "documentation": [" Invalid hash"]
            },
            {
              "name": "NoProposal",
              "documentation": [" No external proposal"]
            },
            {
              "name": "AlreadyVetoed",
              "documentation": [" Identity may not veto a proposal twice"]
            },
            {
              "name": "NotDelegated",
              "documentation": [" Not delegated"]
            },
            {
              "name": "DuplicatePreimage",
              "documentation": [" Preimage already noted"]
            },
            {
              "name": "NotImminent",
              "documentation": [" Not imminent"]
            },
            {
              "name": "TooEarly",
              "documentation": [" Too early"]
            },
            {
              "name": "Imminent",
              "documentation": [" Imminent"]
            },
            {
              "name": "PreimageMissing",
              "documentation": [" Preimage not found"]
            },
            {
              "name": "ReferendumInvalid",
              "documentation": [" Vote given for invalid referendum"]
            },
            {
              "name": "PreimageInvalid",
              "documentation": [" Invalid preimage"]
            },
            {
              "name": "NoneWaiting",
              "documentation": [" No proposals waiting"]
            },
            {
              "name": "NotLocked",
              "documentation": [" The target account does not have a lock."]
            },
            {
              "name": "NotExpired",
              "documentation": [" The lock on the account to be unlocked has not yet expired."]
            },
            {
              "name": "NotVoter",
              "documentation": [" The given account did not vote on the referendum."]
            },
            {
              "name": "NoPermission",
              "documentation": [" The actor has no permission to conduct the action."]
            },
            {
              "name": "AlreadyDelegating",
              "documentation": [" The account is already delegating."]
            },
            {
              "name": "Overflow",
              "documentation": [" An unexpected integer overflow occurred."]
            },
            {
              "name": "Underflow",
              "documentation": [" An unexpected integer underflow occurred."]
            },
            {
              "name": "InsufficientFunds",
              "documentation": [" Too high a balance was provided that the account cannot afford."]
            },
            {
              "name": "NotDelegating",
              "documentation": [" The account is not currently delegating."]
            },
            {
              "name": "VotesExist",
              "documentation": [
                " The account currently has votes attached to it and the operation cannot succeed until",
                " these are removed, either through `unvote` or `reap_vote`."
              ]
            },
            {
              "name": "InstantNotAllowed",
              "documentation": [" The instant referendum origin is currently disallowed."]
            },
            {
              "name": "Nonsense",
              "documentation": [" Delegation to oneself makes no sense."]
            },
            {
              "name": "WrongUpperBound",
              "documentation": [" Invalid upper bound."]
            },
            {
              "name": "MaxVotesReached",
              "documentation": [" Maximum number of votes reached."]
            },
            {
              "name": "InvalidWitness",
              "documentation": [" The provided witness data is wrong."]
            },
            {
              "name": "TooManyProposals",
              "documentation": [" Maximum number of proposals reached."]
            }
          ],
          "index": 10
        },
        {
          "name": "Council",
          "storage": {
            "prefix": "Instance1Collective",
            "items": [
              {
                "name": "Proposals",
                "modifier": "Default",
                "type": {"Plain": "Vec<Hash>"},
                "fallback": "0x00",
                "documentation": [" The hashes of the active proposals."]
              },
              {
                "name": "ProposalOf",
                "modifier": "Optional",
                "type": {
                  "Map": {"hasher": "Identity", "key": "Hash", "value": "Proposal", "linked": false}
                },
                "fallback": "0x00",
                "documentation": [" Actual proposal for a given hash, if it's current."]
              },
              {
                "name": "Voting",
                "modifier": "Optional",
                "type": {
                  "Map": {"hasher": "Identity", "key": "Hash", "value": "Votes", "linked": false}
                },
                "fallback": "0x00",
                "documentation": [" Votes on a given proposal, if it is ongoing."]
              },
              {
                "name": "ProposalCount",
                "modifier": "Default",
                "type": {"Plain": "u32"},
                "fallback": "0x00000000",
                "documentation": [" Proposals so far."]
              },
              {
                "name": "Members",
                "modifier": "Default",
                "type": {"Plain": "Vec<AccountId>"},
                "fallback": "0x00",
                "documentation": [
                  " The current members of the collective. This is stored sorted (just by value)."
                ]
              },
              {
                "name": "Prime",
                "modifier": "Optional",
                "type": {"Plain": "AccountId"},
                "fallback": "0x00",
                "documentation": [
                  " The prime member that helps determine the default vote behavior in case of absentations."
                ]
              }
            ]
          },
          "calls": [
            {
              "name": "set_members",
              "args": [
                {"name": "new_members", "type": "Vec<AccountId>"},
                {"name": "prime", "type": "Option<AccountId>"},
                {"name": "old_count", "type": "MemberCount"}
              ],
              "documentation": [
                " Set the collective's membership.",
                "",
                " - `new_members`: The new member list. Be nice to the chain and provide it sorted.",
                " - `prime`: The prime member whose vote sets the default.",
                " - `old_count`: The upper bound for the previous number of members in storage.",
                "                Used for weight estimation.",
                "",
                " Requires root origin.",
                "",
                " NOTE: Does not enforce the expected `MaxMembers` limit on the amount of members, but",
                "       the weight estimations rely on it to estimate dispatchable weight.",
                "",
                " # <weight>",
                " ## Weight",
                " - `O(MP + N)` where:",
                "   - `M` old-members-count (code- and governance-bounded)",
                "   - `N` new-members-count (code- and governance-bounded)",
                "   - `P` proposals-count (code-bounded)",
                " - DB:",
                "   - 1 storage mutation (codec `O(M)` read, `O(N)` write) for reading and writing the members",
                "   - 1 storage read (codec `O(P)`) for reading the proposals",
                "   - `P` storage mutations (codec `O(M)`) for updating the votes for each proposal",
                "   - 1 storage write (codec `O(1)`) for deleting the old `prime` and setting the new one",
                " # </weight>"
              ]
            },
            {
              "name": "execute",
              "args": [
                {"name": "proposal", "type": "Proposal"},
                {"name": "length_bound", "type": "Compact<u32>"}
              ],
              "documentation": [
                " Dispatch a proposal from a member using the `Member` origin.",
                "",
                " Origin must be a member of the collective.",
                "",
                " # <weight>",
                " ## Weight",
                " - `O(M + P)` where `M` members-count (code-bounded) and `P` complexity of dispatching `proposal`",
                " - DB: 1 read (codec `O(M)`) + DB access of `proposal`",
                " - 1 event",
                " # </weight>"
              ]
            },
            {
              "name": "propose",
              "args": [
                {"name": "threshold", "type": "Compact<MemberCount>"},
                {"name": "proposal", "type": "Proposal"},
                {"name": "length_bound", "type": "Compact<u32>"}
              ],
              "documentation": [
                " Add a new proposal to either be voted on or executed directly.",
                "",
                " Requires the sender to be member.",
                "",
                " `threshold` determines whether `proposal` is executed directly (`threshold < 2`)",
                " or put up for voting.",
                "",
                " # <weight>",
                " ## Weight",
                " - `O(B + M + P1)` or `O(B + M + P2)` where:",
                "   - `B` is `proposal` size in bytes (length-fee-bounded)",
                "   - `M` is members-count (code- and governance-bounded)",
                "   - branching is influenced by `threshold` where:",
                "     - `P1` is proposal execution complexity (`threshold < 2`)",
                "     - `P2` is proposals-count (code-bounded) (`threshold >= 2`)",
                " - DB:",
                "   - 1 storage read `is_member` (codec `O(M)`)",
                "   - 1 storage read `ProposalOf::contains_key` (codec `O(1)`)",
                "   - DB accesses influenced by `threshold`:",
                "     - EITHER storage accesses done by `proposal` (`threshold < 2`)",
                "     - OR proposal insertion (`threshold <= 2`)",
                "       - 1 storage mutation `Proposals` (codec `O(P2)`)",
                "       - 1 storage mutation `ProposalCount` (codec `O(1)`)",
                "       - 1 storage write `ProposalOf` (codec `O(B)`)",
                "       - 1 storage write `Voting` (codec `O(M)`)",
                "   - 1 event",
                " # </weight>"
              ]
            },
            {
              "name": "vote",
              "args": [
                {"name": "proposal", "type": "Hash"},
                {"name": "index", "type": "Compact<ProposalIndex>"},
                {"name": "approve", "type": "bool"}
              ],
              "documentation": [
                " Add an aye or nay vote for the sender to the given proposal.",
                "",
                " Requires the sender to be a member.",
                "",
                " # <weight>",
                " ## Weight",
                " - `O(M)` where `M` is members-count (code- and governance-bounded)",
                " - DB:",
                "   - 1 storage read `Members` (codec `O(M)`)",
                "   - 1 storage mutation `Voting` (codec `O(M)`)",
                " - 1 event",
                " # </weight>"
              ]
            },
            {
              "name": "close",
              "args": [
                {"name": "proposal_hash", "type": "Hash"},
                {"name": "index", "type": "Compact<ProposalIndex>"},
                {"name": "proposal_weight_bound", "type": "Compact<Weight>"},
                {"name": "length_bound", "type": "Compact<u32>"}
              ],
              "documentation": [
                " Close a vote that is either approved, disapproved or whose voting period has ended.",
                "",
                " May be called by any signed account in order to finish voting and close the proposal.",
                "",
                " If called before the end of the voting period it will only close the vote if it is",
                " has enough votes to be approved or disapproved.",
                "",
                " If called after the end of the voting period abstentions are counted as rejections",
                " unless there is a prime member set and the prime member cast an approval.",
                "",
                " + `proposal_weight_bound`: The maximum amount of weight consumed by executing the closed proposal.",
                " + `length_bound`: The upper bound for the length of the proposal in storage. Checked via",
                "                   `storage::read` so it is `size_of::<u32>() == 4` larger than the pure length.",
                "",
                " # <weight>",
                " ## Weight",
                " - `O(B + M + P1 + P2)` where:",
                "   - `B` is `proposal` size in bytes (length-fee-bounded)",
                "   - `M` is members-count (code- and governance-bounded)",
                "   - `P1` is the complexity of `proposal` preimage.",
                "   - `P2` is proposal-count (code-bounded)",
                " - DB:",
                "  - 2 storage reads (`Members`: codec `O(M)`, `Prime`: codec `O(1)`)",
                "  - 3 mutations (`Voting`: codec `O(M)`, `ProposalOf`: codec `O(B)`, `Proposals`: codec `O(P2)`)",
                "  - any mutations done while executing `proposal` (`P1`)",
                " - up to 3 events",
                " # </weight>"
              ]
            },
            {
              "name": "disapprove_proposal",
              "args": [
                {"name": "proposal_hash", "type": "Hash"}
              ],
              "documentation": [
                " Disapprove a proposal, close, and remove it from the system, regardless of its current state.",
                "",
                " Must be called by the Root origin.",
                "",
                " Parameters:",
                " * `proposal_hash`: The hash of the proposal that should be disapproved.",
                "",
                " # <weight>",
                " Complexity: O(P) where P is the number of max proposals",
                " DB Weight:",
                " * Reads: Proposals",
                " * Writes: Voting, Proposals, ProposalOf",
                " # </weight>"
              ]
            }
          ],
          "events": [
            {
              "name": "Proposed",
              "args": ["AccountId", "ProposalIndex", "Hash", "MemberCount"],
              "documentation": [
                " A motion (given hash) has been proposed (by given account) with a threshold (given",
                " `MemberCount`).",
                " \\[account, proposal_index, proposal_hash, threshold\\]"
              ]
            },
            {
              "name": "Voted",
              "args": ["AccountId", "Hash", "bool", "MemberCount", "MemberCount"],
              "documentation": [
                " A motion (given hash) has been voted on by given account, leaving",
                " a tally (yes votes and no votes given respectively as `MemberCount`).",
                " \\[account, proposal_hash, voted, yes, no\\]"
              ]
            },
            {
              "name": "Approved",
              "args": ["Hash"],
              "documentation": [
                " A motion was approved by the required threshold.",
                " \\[proposal_hash\\]"
              ]
            },
            {
              "name": "Disapproved",
              "args": ["Hash"],
              "documentation": [
                " A motion was not approved by the required threshold.",
                " \\[proposal_hash\\]"
              ]
            },
            {
              "name": "Executed",
              "args": ["Hash", "DispatchResult"],
              "documentation": [
                " A motion was executed; result will be `Ok` if it returned without error.",
                " \\[proposal_hash, result\\]"
              ]
            },
            {
              "name": "MemberExecuted",
              "args": ["Hash", "DispatchResult"],
              "documentation": [
                " A single member did some action; result will be `Ok` if it returned without error.",
                " \\[proposal_hash, result\\]"
              ]
            },
            {
              "name": "Closed",
              "args": ["Hash", "MemberCount", "MemberCount"],
              "documentation": [
                " A proposal was closed because its threshold was reached or after its duration was up.",
                " \\[proposal_hash, yes, no\\]"
              ]
            }
          ],
          "constants": [],
          "errors": [
            {
              "name": "NotMember",
              "documentation": [" Account is not a member"]
            },
            {
              "name": "DuplicateProposal",
              "documentation": [" Duplicate proposals not allowed"]
            },
            {
              "name": "ProposalMissing",
              "documentation": [" Proposal must exist"]
            },
            {
              "name": "WrongIndex",
              "documentation": [" Mismatched index"]
            },
            {
              "name": "DuplicateVote",
              "documentation": [" Duplicate vote ignored"]
            },
            {
              "name": "AlreadyInitialized",
              "documentation": [" Members are already initialized!"]
            },
            {
              "name": "TooEarly",
              "documentation": [" The close call was made too early, before the end of the voting."]
            },
            {
              "name": "TooManyProposals",
              "documentation": [" There can only be a maximum of `MaxProposals` active proposals."]
            },
            {
              "name": "WrongProposalWeight",
              "documentation": [" The given weight bound for the proposal was too low."]
            },
            {
              "name": "WrongProposalLength",
              "documentation": [" The given length bound for the proposal was too low."]
            }
          ],
          "index": 11
        },
        {
          "name": "TechnicalCommittee",
          "storage": {
            "prefix": "Instance2Collective",
            "items": [
              {
                "name": "Proposals",
                "modifier": "Default",
                "type": {"Plain": "Vec<Hash>"},
                "fallback": "0x00",
                "documentation": [" The hashes of the active proposals."]
              },
              {
                "name": "ProposalOf",
                "modifier": "Optional",
                "type": {
                  "Map": {"hasher": "Identity", "key": "Hash", "value": "Proposal", "linked": false}
                },
                "fallback": "0x00",
                "documentation": [" Actual proposal for a given hash, if it's current."]
              },
              {
                "name": "Voting",
                "modifier": "Optional",
                "type": {
                  "Map": {"hasher": "Identity", "key": "Hash", "value": "Votes", "linked": false}
                },
                "fallback": "0x00",
                "documentation": [" Votes on a given proposal, if it is ongoing."]
              },
              {
                "name": "ProposalCount",
                "modifier": "Default",
                "type": {"Plain": "u32"},
                "fallback": "0x00000000",
                "documentation": [" Proposals so far."]
              },
              {
                "name": "Members",
                "modifier": "Default",
                "type": {"Plain": "Vec<AccountId>"},
                "fallback": "0x00",
                "documentation": [
                  " The current members of the collective. This is stored sorted (just by value)."
                ]
              },
              {
                "name": "Prime",
                "modifier": "Optional",
                "type": {"Plain": "AccountId"},
                "fallback": "0x00",
                "documentation": [
                  " The prime member that helps determine the default vote behavior in case of absentations."
                ]
              }
            ]
          },
          "calls": [
            {
              "name": "set_members",
              "args": [
                {"name": "new_members", "type": "Vec<AccountId>"},
                {"name": "prime", "type": "Option<AccountId>"},
                {"name": "old_count", "type": "MemberCount"}
              ],
              "documentation": [
                " Set the collective's membership.",
                "",
                " - `new_members`: The new member list. Be nice to the chain and provide it sorted.",
                " - `prime`: The prime member whose vote sets the default.",
                " - `old_count`: The upper bound for the previous number of members in storage.",
                "                Used for weight estimation.",
                "",
                " Requires root origin.",
                "",
                " NOTE: Does not enforce the expected `MaxMembers` limit on the amount of members, but",
                "       the weight estimations rely on it to estimate dispatchable weight.",
                "",
                " # <weight>",
                " ## Weight",
                " - `O(MP + N)` where:",
                "   - `M` old-members-count (code- and governance-bounded)",
                "   - `N` new-members-count (code- and governance-bounded)",
                "   - `P` proposals-count (code-bounded)",
                " - DB:",
                "   - 1 storage mutation (codec `O(M)` read, `O(N)` write) for reading and writing the members",
                "   - 1 storage read (codec `O(P)`) for reading the proposals",
                "   - `P` storage mutations (codec `O(M)`) for updating the votes for each proposal",
                "   - 1 storage write (codec `O(1)`) for deleting the old `prime` and setting the new one",
                " # </weight>"
              ]
            },
            {
              "name": "execute",
              "args": [
                {"name": "proposal", "type": "Proposal"},
                {"name": "length_bound", "type": "Compact<u32>"}
              ],
              "documentation": [
                " Dispatch a proposal from a member using the `Member` origin.",
                "",
                " Origin must be a member of the collective.",
                "",
                " # <weight>",
                " ## Weight",
                " - `O(M + P)` where `M` members-count (code-bounded) and `P` complexity of dispatching `proposal`",
                " - DB: 1 read (codec `O(M)`) + DB access of `proposal`",
                " - 1 event",
                " # </weight>"
              ]
            },
            {
              "name": "propose",
              "args": [
                {"name": "threshold", "type": "Compact<MemberCount>"},
                {"name": "proposal", "type": "Proposal"},
                {"name": "length_bound", "type": "Compact<u32>"}
              ],
              "documentation": [
                " Add a new proposal to either be voted on or executed directly.",
                "",
                " Requires the sender to be member.",
                "",
                " `threshold` determines whether `proposal` is executed directly (`threshold < 2`)",
                " or put up for voting.",
                "",
                " # <weight>",
                " ## Weight",
                " - `O(B + M + P1)` or `O(B + M + P2)` where:",
                "   - `B` is `proposal` size in bytes (length-fee-bounded)",
                "   - `M` is members-count (code- and governance-bounded)",
                "   - branching is influenced by `threshold` where:",
                "     - `P1` is proposal execution complexity (`threshold < 2`)",
                "     - `P2` is proposals-count (code-bounded) (`threshold >= 2`)",
                " - DB:",
                "   - 1 storage read `is_member` (codec `O(M)`)",
                "   - 1 storage read `ProposalOf::contains_key` (codec `O(1)`)",
                "   - DB accesses influenced by `threshold`:",
                "     - EITHER storage accesses done by `proposal` (`threshold < 2`)",
                "     - OR proposal insertion (`threshold <= 2`)",
                "       - 1 storage mutation `Proposals` (codec `O(P2)`)",
                "       - 1 storage mutation `ProposalCount` (codec `O(1)`)",
                "       - 1 storage write `ProposalOf` (codec `O(B)`)",
                "       - 1 storage write `Voting` (codec `O(M)`)",
                "   - 1 event",
                " # </weight>"
              ]
            },
            {
              "name": "vote",
              "args": [
                {"name": "proposal", "type": "Hash"},
                {"name": "index", "type": "Compact<ProposalIndex>"},
                {"name": "approve", "type": "bool"}
              ],
              "documentation": [
                " Add an aye or nay vote for the sender to the given proposal.",
                "",
                " Requires the sender to be a member.",
                "",
                " # <weight>",
                " ## Weight",
                " - `O(M)` where `M` is members-count (code- and governance-bounded)",
                " - DB:",
                "   - 1 storage read `Members` (codec `O(M)`)",
                "   - 1 storage mutation `Voting` (codec `O(M)`)",
                " - 1 event",
                " # </weight>"
              ]
            },
            {
              "name": "close",
              "args": [
                {"name": "proposal_hash", "type": "Hash"},
                {"name": "index", "type": "Compact<ProposalIndex>"},
                {"name": "proposal_weight_bound", "type": "Compact<Weight>"},
                {"name": "length_bound", "type": "Compact<u32>"}
              ],
              "documentation": [
                " Close a vote that is either approved, disapproved or whose voting period has ended.",
                "",
                " May be called by any signed account in order to finish voting and close the proposal.",
                "",
                " If called before the end of the voting period it will only close the vote if it is",
                " has enough votes to be approved or disapproved.",
                "",
                " If called after the end of the voting period abstentions are counted as rejections",
                " unless there is a prime member set and the prime member cast an approval.",
                "",
                " + `proposal_weight_bound`: The maximum amount of weight consumed by executing the closed proposal.",
                " + `length_bound`: The upper bound for the length of the proposal in storage. Checked via",
                "                   `storage::read` so it is `size_of::<u32>() == 4` larger than the pure length.",
                "",
                " # <weight>",
                " ## Weight",
                " - `O(B + M + P1 + P2)` where:",
                "   - `B` is `proposal` size in bytes (length-fee-bounded)",
                "   - `M` is members-count (code- and governance-bounded)",
                "   - `P1` is the complexity of `proposal` preimage.",
                "   - `P2` is proposal-count (code-bounded)",
                " - DB:",
                "  - 2 storage reads (`Members`: codec `O(M)`, `Prime`: codec `O(1)`)",
                "  - 3 mutations (`Voting`: codec `O(M)`, `ProposalOf`: codec `O(B)`, `Proposals`: codec `O(P2)`)",
                "  - any mutations done while executing `proposal` (`P1`)",
                " - up to 3 events",
                " # </weight>"
              ]
            },
            {
              "name": "disapprove_proposal",
              "args": [
                {"name": "proposal_hash", "type": "Hash"}
              ],
              "documentation": [
                " Disapprove a proposal, close, and remove it from the system, regardless of its current state.",
                "",
                " Must be called by the Root origin.",
                "",
                " Parameters:",
                " * `proposal_hash`: The hash of the proposal that should be disapproved.",
                "",
                " # <weight>",
                " Complexity: O(P) where P is the number of max proposals",
                " DB Weight:",
                " * Reads: Proposals",
                " * Writes: Voting, Proposals, ProposalOf",
                " # </weight>"
              ]
            }
          ],
          "events": [
            {
              "name": "Proposed",
              "args": ["AccountId", "ProposalIndex", "Hash", "MemberCount"],
              "documentation": [
                " A motion (given hash) has been proposed (by given account) with a threshold (given",
                " `MemberCount`).",
                " \\[account, proposal_index, proposal_hash, threshold\\]"
              ]
            },
            {
              "name": "Voted",
              "args": ["AccountId", "Hash", "bool", "MemberCount", "MemberCount"],
              "documentation": [
                " A motion (given hash) has been voted on by given account, leaving",
                " a tally (yes votes and no votes given respectively as `MemberCount`).",
                " \\[account, proposal_hash, voted, yes, no\\]"
              ]
            },
            {
              "name": "Approved",
              "args": ["Hash"],
              "documentation": [
                " A motion was approved by the required threshold.",
                " \\[proposal_hash\\]"
              ]
            },
            {
              "name": "Disapproved",
              "args": ["Hash"],
              "documentation": [
                " A motion was not approved by the required threshold.",
                " \\[proposal_hash\\]"
              ]
            },
            {
              "name": "Executed",
              "args": ["Hash", "DispatchResult"],
              "documentation": [
                " A motion was executed; result will be `Ok` if it returned without error.",
                " \\[proposal_hash, result\\]"
              ]
            },
            {
              "name": "MemberExecuted",
              "args": ["Hash", "DispatchResult"],
              "documentation": [
                " A single member did some action; result will be `Ok` if it returned without error.",
                " \\[proposal_hash, result\\]"
              ]
            },
            {
              "name": "Closed",
              "args": ["Hash", "MemberCount", "MemberCount"],
              "documentation": [
                " A proposal was closed because its threshold was reached or after its duration was up.",
                " \\[proposal_hash, yes, no\\]"
              ]
            }
          ],
          "constants": [],
          "errors": [
            {
              "name": "NotMember",
              "documentation": [" Account is not a member"]
            },
            {
              "name": "DuplicateProposal",
              "documentation": [" Duplicate proposals not allowed"]
            },
            {
              "name": "ProposalMissing",
              "documentation": [" Proposal must exist"]
            },
            {
              "name": "WrongIndex",
              "documentation": [" Mismatched index"]
            },
            {
              "name": "DuplicateVote",
              "documentation": [" Duplicate vote ignored"]
            },
            {
              "name": "AlreadyInitialized",
              "documentation": [" Members are already initialized!"]
            },
            {
              "name": "TooEarly",
              "documentation": [" The close call was made too early, before the end of the voting."]
            },
            {
              "name": "TooManyProposals",
              "documentation": [" There can only be a maximum of `MaxProposals` active proposals."]
            },
            {
              "name": "WrongProposalWeight",
              "documentation": [" The given weight bound for the proposal was too low."]
            },
            {
              "name": "WrongProposalLength",
              "documentation": [" The given length bound for the proposal was too low."]
            }
          ],
          "index": 12
        },
        {
          "name": "Elections",
          "storage": {
            "prefix": "PhragmenElection",
            "items": [
              {
                "name": "Members",
                "modifier": "Default",
                "type": {"Plain": "Vec<(AccountId,BalanceOf)>"},
                "fallback": "0x00",
                "documentation": [" The current elected membership. Sorted based on account id."]
              },
              {
                "name": "RunnersUp",
                "modifier": "Default",
                "type": {"Plain": "Vec<(AccountId,BalanceOf)>"},
                "fallback": "0x00",
                "documentation": [
                  " The current runners_up. Sorted based on low to high merit (worse to best)."
                ]
              },
              {
                "name": "ElectionRounds",
                "modifier": "Default",
                "type": {"Plain": "u32"},
                "fallback": "0x00000000",
                "documentation": [
                  " The total number of vote rounds that have happened, excluding the upcoming one."
                ]
              },
              {
                "name": "Voting",
                "modifier": "Default",
                "type": {
                  "Map": {
                    "hasher": "Twox64Concat",
                    "key": "AccountId",
                    "value": "(BalanceOf,Vec<AccountId>)",
                    "linked": false
                  }
                },
                "fallback": "0x0000000000000000000000000000000000",
                "documentation": [
                  " Votes and locked stake of a particular voter.",
                  "",
                  " TWOX-NOTE: SAFE as `AccountId` is a crypto hash"
                ]
              },
              {
                "name": "Candidates",
                "modifier": "Default",
                "type": {"Plain": "Vec<AccountId>"},
                "fallback": "0x00",
                "documentation": [
                  " The present candidate list. Sorted based on account-id. A current member or runner-up",
                  " can never enter this vector and is always implicitly assumed to be a candidate."
                ]
              }
            ]
          },
          "calls": [
            {
              "name": "vote",
              "args": [
                {"name": "votes", "type": "Vec<AccountId>"},
                {"name": "value", "type": "Compact<BalanceOf>"}
              ],
              "documentation": [
                " Vote for a set of candidates for the upcoming round of election. This can be called to",
                " set the initial votes, or update already existing votes.",
                "",
                " Upon initial voting, `value` units of `who`'s balance is locked and a bond amount is",
                " reserved.",
                "",
                " The `votes` should:",
                "   - not be empty.",
                "   - be less than the number of possible candidates. Note that all current members and",
                "     runners-up are also automatically candidates for the next round.",
                "",
                " It is the responsibility of the caller to not place all of their balance into the lock",
                " and keep some for further transactions.",
                "",
                " # <weight>",
                " Base weight: 47.93 µs",
                " State reads:",
                " \t- Candidates.len() + Members.len() + RunnersUp.len()",
                " \t- Voting (is_voter)",
                " \t- Lock",
                " \t- [AccountBalance(who) (unreserve + total_balance)]",
                " State writes:",
                " \t- Voting",
                " \t- Lock",
                " \t- [AccountBalance(who) (unreserve -- only when creating a new voter)]",
                " # </weight>"
              ]
            },
            {
              "name": "remove_voter",
              "args": [],
              "documentation": [
                " Remove `origin` as a voter. This removes the lock and returns the bond.",
                "",
                " # <weight>",
                " Base weight: 36.8 µs",
                " All state access is from do_remove_voter.",
                " State reads:",
                " \t- Voting",
                " \t- [AccountData(who)]",
                " State writes:",
                " \t- Voting",
                " \t- Locks",
                " \t- [AccountData(who)]",
                " # </weight>"
              ]
            },
            {
              "name": "report_defunct_voter",
              "args": [
                {"name": "defunct", "type": "DefunctVoter"}
              ],
              "documentation": [
                " Report `target` for being an defunct voter. In case of a valid report, the reporter is",
                " rewarded by the bond amount of `target`. Otherwise, the reporter itself is removed and",
                " their bond is slashed.",
                "",
                " A defunct voter is defined to be:",
                "   - a voter whose current submitted votes are all invalid. i.e. all of them are no",
                "     longer a candidate nor an active member or a runner-up.",
                "",
                "",
                " The origin must provide the number of current candidates and votes of the reported target",
                " for the purpose of accurate weight calculation.",
                "",
                " # <weight>",
                " No Base weight based on min square analysis.",
                " Complexity of candidate_count: 1.755 µs",
                " Complexity of vote_count: 18.51 µs",
                " State reads:",
                "  \t- Voting(reporter)",
                "  \t- Candidate.len()",
                "  \t- Voting(Target)",
                "  \t- Candidates, Members, RunnersUp (is_defunct_voter)",
                " State writes:",
                " \t- Lock(reporter || target)",
                " \t- [AccountBalance(reporter)] + AccountBalance(target)",
                " \t- Voting(reporter || target)",
                " Note: the db access is worse with respect to db, which is when the report is correct.",
                " # </weight>"
              ]
            },
            {
              "name": "submit_candidacy",
              "args": [
                {"name": "candidate_count", "type": "Compact<u32>"}
              ],
              "documentation": [
                " Submit oneself for candidacy.",
                "",
                " A candidate will either:",
                "   - Lose at the end of the term and forfeit their deposit.",
                "   - Win and become a member. Members will eventually get their stash back.",
                "   - Become a runner-up. Runners-ups are reserved members in case one gets forcefully",
                "     removed.",
                "",
                " # <weight>",
                " Base weight = 33.33 µs",
                " Complexity of candidate_count: 0.375 µs",
                " State reads:",
                " \t- Candidates",
                " \t- Members",
                " \t- RunnersUp",
                " \t- [AccountBalance(who)]",
                " State writes:",
                " \t- [AccountBalance(who)]",
                " \t- Candidates",
                " # </weight>"
              ]
            },
            {
              "name": "renounce_candidacy",
              "args": [
                {"name": "renouncing", "type": "Renouncing"}
              ],
              "documentation": [
                " Renounce one's intention to be a candidate for the next election round. 3 potential",
                " outcomes exist:",
                " - `origin` is a candidate and not elected in any set. In this case, the bond is",
                "   unreserved, returned and origin is removed as a candidate.",
                " - `origin` is a current runner-up. In this case, the bond is unreserved, returned and",
                "   origin is removed as a runner-up.",
                " - `origin` is a current member. In this case, the bond is unreserved and origin is",
                "   removed as a member, consequently not being a candidate for the next round anymore.",
                "   Similar to [`remove_voter`], if replacement runners exists, they are immediately used.",
                " <weight>",
                " If a candidate is renouncing:",
                " \tBase weight: 17.28 µs",
                " \tComplexity of candidate_count: 0.235 µs",
                " \tState reads:",
                " \t\t- Candidates",
                " \t\t- [AccountBalance(who) (unreserve)]",
                " \tState writes:",
                " \t\t- Candidates",
                " \t\t- [AccountBalance(who) (unreserve)]",
                " If member is renouncing:",
                " \tBase weight: 46.25 µs",
                " \tState reads:",
                " \t\t- Members, RunnersUp (remove_and_replace_member),",
                " \t\t- [AccountData(who) (unreserve)]",
                " \tState writes:",
                " \t\t- Members, RunnersUp (remove_and_replace_member),",
                " \t\t- [AccountData(who) (unreserve)]",
                " If runner is renouncing:",
                " \tBase weight: 46.25 µs",
                " \tState reads:",
                " \t\t- RunnersUp (remove_and_replace_member),",
                " \t\t- [AccountData(who) (unreserve)]",
                " \tState writes:",
                " \t\t- RunnersUp (remove_and_replace_member),",
                " \t\t- [AccountData(who) (unreserve)]",
                " </weight>"
              ]
            },
            {
              "name": "remove_member",
              "args": [
                {"name": "who", "type": "LookupSource"},
                {"name": "has_replacement", "type": "bool"}
              ],
              "documentation": [
                " Remove a particular member from the set. This is effective immediately and the bond of",
                " the outgoing member is slashed.",
                "",
                " If a runner-up is available, then the best runner-up will be removed and replaces the",
                " outgoing member. Otherwise, a new phragmen election is started.",
                "",
                " Note that this does not affect the designated block number of the next election.",
                "",
                " # <weight>",
                " If we have a replacement:",
                " \t- Base weight: 50.93 µs",
                " \t- State reads:",
                " \t\t- RunnersUp.len()",
                " \t\t- Members, RunnersUp (remove_and_replace_member)",
                " \t- State writes:",
                " \t\t- Members, RunnersUp (remove_and_replace_member)",
                " Else, since this is a root call and will go into phragmen, we assume full block for now.",
                " # </weight>"
              ]
            }
          ],
          "events": [
            {
              "name": "NewTerm",
              "args": ["Vec<(AccountId,Balance)>"],
              "documentation": [
                " A new term with \\[new_members\\]. This indicates that enough candidates existed to run the",
                " election, not that enough have has been elected. The inner value must be examined for",
                " this purpose. A `NewTerm(\\[\\])` indicates that some candidates got their bond slashed and",
                " none were elected, whilst `EmptyTerm` means that no candidates existed to begin with."
              ]
            },
            {
              "name": "EmptyTerm",
              "args": [],
              "documentation": [
                " No (or not enough) candidates existed for this round. This is different from",
                " `NewTerm(\\[\\])`. See the description of `NewTerm`."
              ]
            },
            {
              "name": "ElectionError",
              "args": [],
              "documentation": [" Internal error happened while trying to perform election."]
            },
            {
              "name": "MemberKicked",
              "args": ["AccountId"],
              "documentation": [
                " A \\[member\\] has been removed. This should always be followed by either `NewTerm` or",
                " `EmptyTerm`."
              ]
            },
            {
              "name": "MemberRenounced",
              "args": ["AccountId"],
              "documentation": [" A \\[member\\] has renounced their candidacy."]
            },
            {
              "name": "VoterReported",
              "args": ["AccountId", "AccountId", "bool"],
              "documentation": [
                " A voter was reported with the the report being successful or not.",
                " \\[voter, reporter, success\\]"
              ]
            }
          ],
          "constants": [
            {
              "name": "CandidacyBond",
              "type": "BalanceOf",
              "value": "0x0080c6a47e8d03000000000000000000",
              "documentation": []
            },
            {
              "name": "VotingBond",
              "type": "BalanceOf",
              "value": "0x00407a10f35a00000000000000000000",
              "documentation": []
            },
            {"name": "DesiredMembers", "type": "u32", "value": "0x0d000000", "documentation": []},
            {"name": "DesiredRunnersUp", "type": "u32", "value": "0x07000000", "documentation": []},
            {
              "name": "TermDuration",
              "type": "BlockNumber",
              "value": "0x80130300",
              "documentation": []
            },
            {
              "name": "ModuleId",
              "type": "LockIdentifier",
              "value": "0x706872656c656374",
              "documentation": []
            }
          ],
          "errors": [
            {
              "name": "UnableToVote",
              "documentation": [" Cannot vote when no candidates or members exist."]
            },
            {
              "name": "NoVotes",
              "documentation": [" Must vote for at least one candidate."]
            },
            {
              "name": "TooManyVotes",
              "documentation": [" Cannot vote more than candidates."]
            },
            {
              "name": "MaximumVotesExceeded",
              "documentation": [" Cannot vote more than maximum allowed."]
            },
            {
              "name": "LowBalance",
              "documentation": [" Cannot vote with stake less than minimum balance."]
            },
            {
              "name": "UnableToPayBond",
              "documentation": [" Voter can not pay voting bond."]
            },
            {
              "name": "MustBeVoter",
              "documentation": [" Must be a voter."]
            },
            {
              "name": "ReportSelf",
              "documentation": [" Cannot report self."]
            },
            {
              "name": "DuplicatedCandidate",
              "documentation": [" Duplicated candidate submission."]
            },
            {
              "name": "MemberSubmit",
              "documentation": [" Member cannot re-submit candidacy."]
            },
            {
              "name": "RunnerSubmit",
              "documentation": [" Runner cannot re-submit candidacy."]
            },
            {
              "name": "InsufficientCandidateFunds",
              "documentation": [" Candidate does not have enough funds."]
            },
            {
              "name": "NotMember",
              "documentation": [" Not a member."]
            },
            {
              "name": "InvalidCandidateCount",
              "documentation": [" The provided count of number of candidates is incorrect."]
            },
            {
              "name": "InvalidVoteCount",
              "documentation": [" The provided count of number of votes is incorrect."]
            },
            {
              "name": "InvalidRenouncing",
              "documentation": [" The renouncing origin presented a wrong `Renouncing` parameter."]
            },
            {
              "name": "InvalidReplacement",
              "documentation": [" Prediction regarding replacement after member removal is wrong."]
            }
          ],
          "index": 13
        },
        {
          "name": "TechnicalMembership",
          "storage": {
            "prefix": "Instance1Membership",
            "items": [
              {
                "name": "Members",
                "modifier": "Default",
                "type": {"Plain": "Vec<AccountId>"},
                "fallback": "0x00",
                "documentation": [" The current membership, stored as an ordered Vec."]
              },
              {
                "name": "Prime",
                "modifier": "Optional",
                "type": {"Plain": "AccountId"},
                "fallback": "0x00",
                "documentation": [" The current prime member, if one exists."]
              }
            ]
          },
          "calls": [
            {
              "name": "add_member",
              "args": [
                {"name": "who", "type": "AccountId"}
              ],
              "documentation": [
                " Add a member `who` to the set.",
                "",
                " May only be called from `T::AddOrigin`."
              ]
            },
            {
              "name": "remove_member",
              "args": [
                {"name": "who", "type": "AccountId"}
              ],
              "documentation": [
                " Remove a member `who` from the set.",
                "",
                " May only be called from `T::RemoveOrigin`."
              ]
            },
            {
              "name": "swap_member",
              "args": [
                {"name": "remove", "type": "AccountId"},
                {"name": "add", "type": "AccountId"}
              ],
              "documentation": [
                " Swap out one member `remove` for another `add`.",
                "",
                " May only be called from `T::SwapOrigin`.",
                "",
                " Prime membership is *not* passed from `remove` to `add`, if extant."
              ]
            },
            {
              "name": "reset_members",
              "args": [
                {"name": "members", "type": "Vec<AccountId>"}
              ],
              "documentation": [
                " Change the membership to a new set, disregarding the existing membership. Be nice and",
                " pass `members` pre-sorted.",
                "",
                " May only be called from `T::ResetOrigin`."
              ]
            },
            {
              "name": "change_key",
              "args": [
                {"name": "new", "type": "AccountId"}
              ],
              "documentation": [
                " Swap out the sending member for some other key `new`.",
                "",
                " May only be called from `Signed` origin of a current member.",
                "",
                " Prime membership is passed from the origin account to `new`, if extant."
              ]
            },
            {
              "name": "set_prime",
              "args": [
                {"name": "who", "type": "AccountId"}
              ],
              "documentation": [
                " Set the prime member. Must be a current member.",
                "",
                " May only be called from `T::PrimeOrigin`."
              ]
            },
            {
              "name": "clear_prime",
              "args": [],
              "documentation": [
                " Remove the prime member if it exists.",
                "",
                " May only be called from `T::PrimeOrigin`."
              ]
            }
          ],
          "events": [
            {
              "name": "MemberAdded",
              "args": [],
              "documentation": [" The given member was added; see the transaction for who."]
            },
            {
              "name": "MemberRemoved",
              "args": [],
              "documentation": [" The given member was removed; see the transaction for who."]
            },
            {
              "name": "MembersSwapped",
              "args": [],
              "documentation": [" Two members were swapped; see the transaction for who."]
            },
            {
              "name": "MembersReset",
              "args": [],
              "documentation": [
                " The membership was reset; see the transaction for who the new set is."
              ]
            },
            {
              "name": "KeyChanged",
              "args": [],
              "documentation": [" One of the members' keys changed."]
            },
            {
              "name": "Dummy",
              "args": ["PhantomData"],
              "documentation": [" Phantom member, never used."]
            }
          ],
          "constants": [],
          "errors": [],
          "index": 14
        },
        {
          "name": "Grandpa",
          "storage": {
            "prefix": "GrandpaFinality",
            "items": [
              {
                "name": "State",
                "modifier": "Default",
                "type": {"Plain": "StoredState"},
                "fallback": "0x00",
                "documentation": [" State of the current authority set."]
              },
              {
                "name": "PendingChange",
                "modifier": "Optional",
                "type": {"Plain": "StoredPendingChange"},
                "fallback": "0x00",
                "documentation": [" Pending change: (signaled at, scheduled change)."]
              },
              {
                "name": "NextForced",
                "modifier": "Optional",
                "type": {"Plain": "BlockNumber"},
                "fallback": "0x00",
                "documentation": [" next block number where we can force a change."]
              },
              {
                "name": "Stalled",
                "modifier": "Optional",
                "type": {"Plain": "(BlockNumber,BlockNumber)"},
                "fallback": "0x00",
                "documentation": [" `true` if we are currently stalled."]
              },
              {
                "name": "CurrentSetId",
                "modifier": "Default",
                "type": {"Plain": "SetId"},
                "fallback": "0x0000000000000000",
                "documentation": [
                  " The number of changes (both in terms of keys and underlying economic responsibilities)",
                  " in the \"set\" of Grandpa validators from genesis."
                ]
              },
              {
                "name": "SetIdSession",
                "modifier": "Optional",
                "type": {
                  "Map": {
                    "hasher": "Twox64Concat",
                    "key": "SetId",
                    "value": "SessionIndex",
                    "linked": false
                  }
                },
                "fallback": "0x00",
                "documentation": [
                  " A mapping from grandpa set ID to the index of the *most recent* session for which its",
                  " members were responsible.",
                  "",
                  " TWOX-NOTE: `SetId` is not under user control."
                ]
              }
            ]
          },
          "calls": [
            {
              "name": "report_equivocation",
              "args": [
                {"name": "equivocation_proof", "type": "GrandpaEquivocationProof"},
                {"name": "key_owner_proof", "type": "KeyOwnerProof"}
              ],
              "documentation": [
                " Report voter equivocation/misbehavior. This method will verify the",
                " equivocation proof and validate the given key ownership proof",
                " against the extracted offender. If both are valid, the offence",
                " will be reported."
              ]
            },
            {
              "name": "report_equivocation_unsigned",
              "args": [
                {"name": "equivocation_proof", "type": "GrandpaEquivocationProof"},
                {"name": "key_owner_proof", "type": "KeyOwnerProof"}
              ],
              "documentation": [
                " Report voter equivocation/misbehavior. This method will verify the",
                " equivocation proof and validate the given key ownership proof",
                " against the extracted offender. If both are valid, the offence",
                " will be reported.",
                "",
                " This extrinsic must be called unsigned and it is expected that only",
                " block authors will call it (validated in `ValidateUnsigned`), as such",
                " if the block author is defined it will be defined as the equivocation",
                " reporter."
              ]
            },
            {
              "name": "note_stalled",
              "args": [
                {"name": "delay", "type": "BlockNumber"},
                {"name": "best_finalized_block_number", "type": "BlockNumber"}
              ],
              "documentation": [
                " Note that the current authority set of the GRANDPA finality gadget has",
                " stalled. This will trigger a forced authority set change at the beginning",
                " of the next session, to be enacted `delay` blocks after that. The delay",
                " should be high enough to safely assume that the block signalling the",
                " forced change will not be re-orged (e.g. 1000 blocks). The GRANDPA voters",
                " will start the new authority set using the given finalized block as base.",
                " Only callable by root."
              ]
            }
          ],
          "events": [
            {
              "name": "NewAuthorities",
              "args": ["AuthorityList"],
              "documentation": [" New authority set has been applied. \\[authority_set\\]"]
            },
            {
              "name": "Paused",
              "args": [],
              "documentation": [" Current authority set has been paused."]
            },
            {
              "name": "Resumed",
              "args": [],
              "documentation": [" Current authority set has been resumed."]
            }
          ],
          "constants": [],
          "errors": [
            {
              "name": "PauseFailed",
              "documentation": [
                " Attempt to signal GRANDPA pause when the authority set isn't live",
                " (either paused or already pending pause)."
              ]
            },
            {
              "name": "ResumeFailed",
              "documentation": [
                " Attempt to signal GRANDPA resume when the authority set isn't paused",
                " (either live or already pending resume)."
              ]
            },
            {
              "name": "ChangePending",
              "documentation": [" Attempt to signal GRANDPA change with one already pending."]
            },
            {
              "name": "TooSoon",
              "documentation": [" Cannot signal forced change so soon after last."]
            },
            {
              "name": "InvalidKeyOwnershipProof",
              "documentation": [
                " A key ownership proof provided as part of an equivocation report is invalid."
              ]
            },
            {
              "name": "InvalidEquivocationProof",
              "documentation": [
                " An equivocation proof provided as part of an equivocation report is invalid."
              ]
            },
            {
              "name": "DuplicateOffenceReport",
              "documentation": [
                " A given equivocation report is valid but already previously reported."
              ]
            }
          ],
          "index": 15
        },
        {
          "name": "Treasury",
          "storage": {
            "prefix": "Treasury",
            "items": [
              {
                "name": "ProposalCount",
                "modifier": "Default",
                "type": {"Plain": "ProposalIndex"},
                "fallback": "0x00000000",
                "documentation": [" Number of proposals that have been made."]
              },
              {
                "name": "Proposals",
                "modifier": "Optional",
                "type": {
                  "Map": {
                    "hasher": "Twox64Concat",
                    "key": "ProposalIndex",
                    "value": "TreasuryProposal",
                    "linked": false
                  }
                },
                "fallback": "0x00",
                "documentation": [" Proposals that have been made."]
              },
              {
                "name": "Approvals",
                "modifier": "Default",
                "type": {"Plain": "Vec<ProposalIndex>"},
                "fallback": "0x00",
                "documentation": [" Proposal indices that have been approved but not yet awarded."]
              },
              {
                "name": "Tips",
                "modifier": "Optional",
                "type": {
                  "Map": {
                    "hasher": "Twox64Concat",
                    "key": "Hash",
                    "value": "OpenTip",
                    "linked": false
                  }
                },
                "fallback": "0x00",
                "documentation": [
                  " Tips that are not yet completed. Keyed by the hash of `(reason, who)` from the value.",
                  " This has the insecure enumerable hash function since the key itself is already",
                  " guaranteed to be a secure hash."
                ]
              },
              {
                "name": "Reasons",
                "modifier": "Optional",
                "type": {
                  "Map": {"hasher": "Identity", "key": "Hash", "value": "Bytes", "linked": false}
                },
                "fallback": "0x00",
                "documentation": [
                  " Simple preimage lookup from the reason's hash to the original data. Again, has an",
                  " insecure enumerable hash since the key is guaranteed to be the result of a secure hash."
                ]
              },
              {
                "name": "BountyCount",
                "modifier": "Default",
                "type": {"Plain": "BountyIndex"},
                "fallback": "0x00000000",
                "documentation": [" Number of bounty proposals that have been made."]
              },
              {
                "name": "Bounties",
                "modifier": "Optional",
                "type": {
                  "Map": {
                    "hasher": "Twox64Concat",
                    "key": "BountyIndex",
                    "value": "Bounty",
                    "linked": false
                  }
                },
                "fallback": "0x00",
                "documentation": [" Bounties that have been made."]
              },
              {
                "name": "BountyDescriptions",
                "modifier": "Optional",
                "type": {
                  "Map": {
                    "hasher": "Twox64Concat",
                    "key": "BountyIndex",
                    "value": "Bytes",
                    "linked": false
                  }
                },
                "fallback": "0x00",
                "documentation": [" The description of each bounty."]
              },
              {
                "name": "BountyApprovals",
                "modifier": "Default",
                "type": {"Plain": "Vec<BountyIndex>"},
                "fallback": "0x00",
                "documentation": [" Bounty indices that have been approved but not yet funded."]
              }
            ]
          },
          "calls": [
            {
              "name": "propose_spend",
              "args": [
                {"name": "value", "type": "Compact<BalanceOf>"},
                {"name": "beneficiary", "type": "LookupSource"}
              ],
              "documentation": [
                " Put forward a suggestion for spending. A deposit proportional to the value",
                " is reserved and slashed if the proposal is rejected. It is returned once the",
                " proposal is awarded.",
                "",
                " # <weight>",
                " - Complexity: O(1)",
                " - DbReads: `ProposalCount`, `origin account`",
                " - DbWrites: `ProposalCount`, `Proposals`, `origin account`",
                " # </weight>"
              ]
            },
            {
              "name": "reject_proposal",
              "args": [
                {"name": "proposal_id", "type": "Compact<ProposalIndex>"}
              ],
              "documentation": [
                " Reject a proposed spend. The original deposit will be slashed.",
                "",
                " May only be called from `T::RejectOrigin`.",
                "",
                " # <weight>",
                " - Complexity: O(1)",
                " - DbReads: `Proposals`, `rejected proposer account`",
                " - DbWrites: `Proposals`, `rejected proposer account`",
                " # </weight>"
              ]
            },
            {
              "name": "approve_proposal",
              "args": [
                {"name": "proposal_id", "type": "Compact<ProposalIndex>"}
              ],
              "documentation": [
                " Approve a proposal. At a later time, the proposal will be allocated to the beneficiary",
                " and the original deposit will be returned.",
                "",
                " May only be called from `T::ApproveOrigin`.",
                "",
                " # <weight>",
                " - Complexity: O(1).",
                " - DbReads: `Proposals`, `Approvals`",
                " - DbWrite: `Approvals`",
                " # </weight>"
              ]
            },
            {
              "name": "report_awesome",
              "args": [
                {"name": "reason", "type": "Bytes"},
                {"name": "who", "type": "AccountId"}
              ],
              "documentation": [
                " Report something `reason` that deserves a tip and claim any eventual the finder's fee.",
                "",
                " The dispatch origin for this call must be _Signed_.",
                "",
                " Payment: `TipReportDepositBase` will be reserved from the origin account, as well as",
                " `DataDepositPerByte` for each byte in `reason`.",
                "",
                " - `reason`: The reason for, or the thing that deserves, the tip; generally this will be",
                "   a UTF-8-encoded URL.",
                " - `who`: The account which should be credited for the tip.",
                "",
                " Emits `NewTip` if successful.",
                "",
                " # <weight>",
                " - Complexity: `O(R)` where `R` length of `reason`.",
                "   - encoding and hashing of 'reason'",
                " - DbReads: `Reasons`, `Tips`",
                " - DbWrites: `Reasons`, `Tips`",
                " # </weight>"
              ]
            },
            {
              "name": "retract_tip",
              "args": [
                {"name": "hash", "type": "Hash"}
              ],
              "documentation": [
                " Retract a prior tip-report from `report_awesome`, and cancel the process of tipping.",
                "",
                " If successful, the original deposit will be unreserved.",
                "",
                " The dispatch origin for this call must be _Signed_ and the tip identified by `hash`",
                " must have been reported by the signing account through `report_awesome` (and not",
                " through `tip_new`).",
                "",
                " - `hash`: The identity of the open tip for which a tip value is declared. This is formed",
                "   as the hash of the tuple of the original tip `reason` and the beneficiary account ID.",
                "",
                " Emits `TipRetracted` if successful.",
                "",
                " # <weight>",
                " - Complexity: `O(1)`",
                "   - Depends on the length of `T::Hash` which is fixed.",
                " - DbReads: `Tips`, `origin account`",
                " - DbWrites: `Reasons`, `Tips`, `origin account`",
                " # </weight>"
              ]
            },
            {
              "name": "tip_new",
              "args": [
                {"name": "reason", "type": "Bytes"},
                {"name": "who", "type": "AccountId"},
                {"name": "tip_value", "type": "Compact<BalanceOf>"}
              ],
              "documentation": [
                " Give a tip for something new; no finder's fee will be taken.",
                "",
                " The dispatch origin for this call must be _Signed_ and the signing account must be a",
                " member of the `Tippers` set.",
                "",
                " - `reason`: The reason for, or the thing that deserves, the tip; generally this will be",
                "   a UTF-8-encoded URL.",
                " - `who`: The account which should be credited for the tip.",
                " - `tip_value`: The amount of tip that the sender would like to give. The median tip",
                "   value of active tippers will be given to the `who`.",
                "",
                " Emits `NewTip` if successful.",
                "",
                " # <weight>",
                " - Complexity: `O(R + T)` where `R` length of `reason`, `T` is the number of tippers.",
                "   - `O(T)`: decoding `Tipper` vec of length `T`",
                "     `T` is charged as upper bound given by `ContainsLengthBound`.",
                "     The actual cost depends on the implementation of `T::Tippers`.",
                "   - `O(R)`: hashing and encoding of reason of length `R`",
                " - DbReads: `Tippers`, `Reasons`",
                " - DbWrites: `Reasons`, `Tips`",
                " # </weight>"
              ]
            },
            {
              "name": "tip",
              "args": [
                {"name": "hash", "type": "Hash"},
                {"name": "tip_value", "type": "Compact<BalanceOf>"}
              ],
              "documentation": [
                " Declare a tip value for an already-open tip.",
                "",
                " The dispatch origin for this call must be _Signed_ and the signing account must be a",
                " member of the `Tippers` set.",
                "",
                " - `hash`: The identity of the open tip for which a tip value is declared. This is formed",
                "   as the hash of the tuple of the hash of the original tip `reason` and the beneficiary",
                "   account ID.",
                " - `tip_value`: The amount of tip that the sender would like to give. The median tip",
                "   value of active tippers will be given to the `who`.",
                "",
                " Emits `TipClosing` if the threshold of tippers has been reached and the countdown period",
                " has started.",
                "",
                " # <weight>",
                " - Complexity: `O(T)` where `T` is the number of tippers.",
                "   decoding `Tipper` vec of length `T`, insert tip and check closing,",
                "   `T` is charged as upper bound given by `ContainsLengthBound`.",
                "   The actual cost depends on the implementation of `T::Tippers`.",
                "",
                "   Actually weight could be lower as it depends on how many tips are in `OpenTip` but it",
                "   is weighted as if almost full i.e of length `T-1`.",
                " - DbReads: `Tippers`, `Tips`",
                " - DbWrites: `Tips`",
                " # </weight>"
              ]
            },
            {
              "name": "close_tip",
              "args": [
                {"name": "hash", "type": "Hash"}
              ],
              "documentation": [
                " Close and payout a tip.",
                "",
                " The dispatch origin for this call must be _Signed_.",
                "",
                " The tip identified by `hash` must have finished its countdown period.",
                "",
                " - `hash`: The identity of the open tip for which a tip value is declared. This is formed",
                "   as the hash of the tuple of the original tip `reason` and the beneficiary account ID.",
                "",
                " # <weight>",
                " - Complexity: `O(T)` where `T` is the number of tippers.",
                "   decoding `Tipper` vec of length `T`.",
                "   `T` is charged as upper bound given by `ContainsLengthBound`.",
                "   The actual cost depends on the implementation of `T::Tippers`.",
                " - DbReads: `Tips`, `Tippers`, `tip finder`",
                " - DbWrites: `Reasons`, `Tips`, `Tippers`, `tip finder`",
                " # </weight>"
              ]
            },
            {
              "name": "propose_bounty",
              "args": [
                {"name": "value", "type": "Compact<BalanceOf>"},
                {"name": "description", "type": "Bytes"}
              ],
              "documentation": [
                " Propose a new bounty.",
                "",
                " The dispatch origin for this call must be _Signed_.",
                "",
                " Payment: `TipReportDepositBase` will be reserved from the origin account, as well as",
                " `DataDepositPerByte` for each byte in `reason`. It will be unreserved upon approval,",
                " or slashed when rejected.",
                "",
                " - `curator`: The curator account whom will manage this bounty.",
                " - `fee`: The curator fee.",
                " - `value`: The total payment amount of this bounty, curator fee included.",
                " - `description`: The description of this bounty."
              ]
            },
            {
              "name": "approve_bounty",
              "args": [
                {"name": "bounty_id", "type": "Compact<ProposalIndex>"}
              ],
              "documentation": [
                " Approve a bounty proposal. At a later time, the bounty will be funded and become active",
                " and the original deposit will be returned.",
                "",
                " May only be called from `T::ApproveOrigin`.",
                "",
                " # <weight>",
                " - O(1).",
                " - Limited storage reads.",
                " - One DB change.",
                " # </weight>"
              ]
            },
            {
              "name": "propose_curator",
              "args": [
                {"name": "bounty_id", "type": "Compact<ProposalIndex>"},
                {"name": "curator", "type": "LookupSource"},
                {"name": "fee", "type": "Compact<BalanceOf>"}
              ],
              "documentation": [
                " Assign a curator to a funded bounty.",
                "",
                " May only be called from `T::ApproveOrigin`.",
                "",
                " # <weight>",
                " - O(1).",
                " - Limited storage reads.",
                " - One DB change.",
                " # </weight>"
              ]
            },
            {
              "name": "unassign_curator",
              "args": [
                {"name": "bounty_id", "type": "Compact<ProposalIndex>"}
              ],
              "documentation": [
                " Unassign curator from a bounty.",
                "",
                " This function can only be called by the `RejectOrigin` a signed origin.",
                "",
                " If this function is called by the `RejectOrigin`, we assume that the curator is malicious",
                " or inactive. As a result, we will slash the curator when possible.",
                "",
                " If the origin is the curator, we take this as a sign they are unable to do their job and",
                " they willingly give up. We could slash them, but for now we allow them to recover their",
                " deposit and exit without issue. (We may want to change this if it is abused.)",
                "",
                " Finally, the origin can be anyone if and only if the curator is \"inactive\". This allows",
                " anyone in the community to call out that a curator is not doing their due diligence, and",
                " we should pick a new curator. In this case the curator should also be slashed.",
                "",
                " # <weight>",
                " - O(1).",
                " - Limited storage reads.",
                " - One DB change.",
                " # </weight>"
              ]
            },
            {
              "name": "accept_curator",
              "args": [
                {"name": "bounty_id", "type": "Compact<ProposalIndex>"}
              ],
              "documentation": [
                " Accept the curator role for a bounty.",
                " A deposit will be reserved from curator and refund upon successful payout.",
                "",
                " May only be called from the curator.",
                "",
                " # <weight>",
                " - O(1).",
                " - Limited storage reads.",
                " - One DB change.",
                " # </weight>"
              ]
            },
            {
              "name": "award_bounty",
              "args": [
                {"name": "bounty_id", "type": "Compact<ProposalIndex>"},
                {"name": "beneficiary", "type": "LookupSource"}
              ],
              "documentation": [
                " Award bounty to a beneficiary account. The beneficiary will be able to claim the funds after a delay.",
                "",
                " The dispatch origin for this call must be the curator of this bounty.",
                "",
                " - `bounty_id`: Bounty ID to award.",
                " - `beneficiary`: The beneficiary account whom will receive the payout."
              ]
            },
            {
              "name": "claim_bounty",
              "args": [
                {"name": "bounty_id", "type": "Compact<BountyIndex>"}
              ],
              "documentation": [
                " Claim the payout from an awarded bounty after payout delay.",
                "",
                " The dispatch origin for this call must be the beneficiary of this bounty.",
                "",
                " - `bounty_id`: Bounty ID to claim."
              ]
            },
            {
              "name": "close_bounty",
              "args": [
                {"name": "bounty_id", "type": "Compact<BountyIndex>"}
              ],
              "documentation": [
                " Cancel a proposed or active bounty. All the funds will be sent to treasury and",
                " the curator deposit will be unreserved if possible.",
                "",
                " Only `T::RejectOrigin` is able to cancel a bounty.",
                "",
                " - `bounty_id`: Bounty ID to cancel."
              ]
            },
            {
              "name": "extend_bounty_expiry",
              "args": [
                {"name": "bounty_id", "type": "Compact<BountyIndex>"},
                {"name": "_remark", "type": "Bytes"}
              ],
              "documentation": [
                " Extend the expiry time of an active bounty.",
                "",
                " The dispatch origin for this call must be the curator of this bounty.",
                "",
                " - `bounty_id`: Bounty ID to extend.",
                " - `remark`: additional information."
              ]
            }
          ],
          "events": [
            {
              "name": "Proposed",
              "args": ["ProposalIndex"],
              "documentation": [" New proposal. \\[proposal_index\\]"]
            },
            {
              "name": "Spending",
              "args": ["Balance"],
              "documentation": [
                " We have ended a spend period and will now allocate funds. \\[budget_remaining\\]"
              ]
            },
            {
              "name": "Awarded",
              "args": ["ProposalIndex", "Balance", "AccountId"],
              "documentation": [
                " Some funds have been allocated. \\[proposal_index, award, beneficiary\\]"
              ]
            },
            {
              "name": "Rejected",
              "args": ["ProposalIndex", "Balance"],
              "documentation": [
                " A proposal was rejected; funds were slashed. \\[proposal_index, slashed\\]"
              ]
            },
            {
              "name": "Burnt",
              "args": ["Balance"],
              "documentation": [" Some of our funds have been burnt. \\[burn\\]"]
            },
            {
              "name": "Rollover",
              "args": ["Balance"],
              "documentation": [
                " Spending has finished; this is the amount that rolls over until next spend.",
                " \\[budget_remaining\\]"
              ]
            },
            {
              "name": "Deposit",
              "args": ["Balance"],
              "documentation": [" Some funds have been deposited. \\[deposit\\]"]
            },
            {
              "name": "NewTip",
              "args": ["Hash"],
              "documentation": [" A new tip suggestion has been opened. \\[tip_hash\\]"]
            },
            {
              "name": "TipClosing",
              "args": ["Hash"],
              "documentation": [
                " A tip suggestion has reached threshold and is closing. \\[tip_hash\\]"
              ]
            },
            {
              "name": "TipClosed",
              "args": ["Hash", "AccountId", "Balance"],
              "documentation": [" A tip suggestion has been closed. \\[tip_hash, who, payout\\]"]
            },
            {
              "name": "TipRetracted",
              "args": ["Hash"],
              "documentation": [" A tip suggestion has been retracted. \\[tip_hash\\]"]
            },
            {
              "name": "BountyProposed",
              "args": ["BountyIndex"],
              "documentation": [" New bounty proposal. [index]"]
            },
            {
              "name": "BountyRejected",
              "args": ["BountyIndex", "Balance"],
              "documentation": [
                " A bounty proposal was rejected; funds were slashed. [index, bond]"
              ]
            },
            {
              "name": "BountyBecameActive",
              "args": ["BountyIndex"],
              "documentation": [" A bounty proposal is funded and became active. [index]"]
            },
            {
              "name": "BountyAwarded",
              "args": ["BountyIndex", "AccountId"],
              "documentation": [" A bounty is awarded to a beneficiary. [index, beneficiary]"]
            },
            {
              "name": "BountyClaimed",
              "args": ["BountyIndex", "Balance", "AccountId"],
              "documentation": [" A bounty is claimed by beneficiary. [index, payout, beneficiary]"]
            },
            {
              "name": "BountyCanceled",
              "args": ["BountyIndex"],
              "documentation": [" A bounty is cancelled. [index]"]
            },
            {
              "name": "BountyExtended",
              "args": ["BountyIndex"],
              "documentation": [" A bounty expiry is extended. [index]"]
            }
          ],
          "constants": [
            {
              "name": "ProposalBond",
              "type": "Permill",
              "value": "0x50c30000",
              "documentation": [
                " Fraction of a proposal's value that should be bonded in order to place the proposal.",
                " An accepted proposal gets these back. A rejected proposal does not."
              ]
            },
            {
              "name": "ProposalBondMinimum",
              "type": "BalanceOf",
              "value": "0x00407a10f35a00000000000000000000",
              "documentation": [
                " Minimum amount of funds that should be placed in a deposit for making a proposal."
              ]
            },
            {
              "name": "SpendPeriod",
              "type": "BlockNumber",
              "value": "0x80700000",
              "documentation": [" Period between successive spends."]
            },
            {
              "name": "Burn",
              "type": "Permill",
              "value": "0x20a10700",
              "documentation": [
                " Percentage of spare funds (if any) that are burnt per spend period."
              ]
            },
            {
              "name": "TipCountdown",
              "type": "BlockNumber",
              "value": "0x80700000",
              "documentation": [
                " The period for which a tip remains open after is has achieved threshold tippers."
              ]
            },
            {
              "name": "TipFindersFee",
              "type": "Percent",
              "value": "0x14",
              "documentation": [
                " The amount of the final tip which goes to the original reporter of the tip."
              ]
            },
            {
              "name": "TipReportDepositBase",
              "type": "BalanceOf",
              "value": "0x00407a10f35a00000000000000000000",
              "documentation": [" The amount held on deposit for placing a tip report."]
            },
            {
              "name": "DataDepositPerByte",
              "type": "BalanceOf",
              "value": "0x0010a5d4e80000000000000000000000",
              "documentation": [
                " The amount held on deposit per byte within the tip report reason or bounty description."
              ]
            },
            {
              "name": "ModuleId",
              "type": "ModuleId",
              "value": "0x70792f7472737279",
              "documentation": [
                " The treasury's module id, used for deriving its sovereign account ID."
              ]
            },
            {
              "name": "BountyDepositBase",
              "type": "BalanceOf",
              "value": "0x00407a10f35a00000000000000000000",
              "documentation": [" The amount held on deposit for placing a bounty proposal."]
            },
            {
              "name": "BountyDepositPayoutDelay",
              "type": "BlockNumber",
              "value": "0x80700000",
              "documentation": [
                " The delay period for which a bounty beneficiary need to wait before claim the payout."
              ]
            },
            {
              "name": "BountyCuratorDeposit",
              "type": "Permill",
              "value": "0x20a10700",
              "documentation": [
                " Percentage of the curator fee that will be reserved upfront as deposit for bounty curator."
              ]
            },
            {
              "name": "BountyValueMinimum",
              "type": "BalanceOf",
              "value": "0x00406352bfc601000000000000000000",
              "documentation": []
            },
            {
              "name": "MaximumReasonLength",
              "type": "u32",
              "value": "0x00400000",
              "documentation": [" Maximum acceptable reason length."]
            }
          ],
          "errors": [
            {
              "name": "InsufficientProposersBalance",
              "documentation": [" Proposer's balance is too low."]
            },
            {
              "name": "InvalidIndex",
              "documentation": [" No proposal or bounty at that index."]
            },
            {
              "name": "ReasonTooBig",
              "documentation": [" The reason given is just too big."]
            },
            {
              "name": "AlreadyKnown",
              "documentation": [" The tip was already found/started."]
            },
            {
              "name": "UnknownTip",
              "documentation": [" The tip hash is unknown."]
            },
            {
              "name": "NotFinder",
              "documentation": [
                " The account attempting to retract the tip is not the finder of the tip."
              ]
            },
            {
              "name": "StillOpen",
              "documentation": [
                " The tip cannot be claimed/closed because there are not enough tippers yet."
              ]
            },
            {
              "name": "Premature",
              "documentation": [
                " The tip cannot be claimed/closed because it's still in the countdown period."
              ]
            },
            {
              "name": "UnexpectedStatus",
              "documentation": [" The bounty status is unexpected."]
            },
            {
              "name": "RequireCurator",
              "documentation": [" Require bounty curator."]
            },
            {
              "name": "InvalidValue",
              "documentation": [" Invalid bounty value."]
            },
            {
              "name": "InvalidFee",
              "documentation": [" Invalid bounty fee."]
            },
            {
              "name": "PendingPayout",
              "documentation": [
                " A bounty payout is pending.",
                " To cancel the bounty, you must unassign and slash the curator."
              ]
            }
          ],
          "index": 16
        },
        {
          "name": "Contracts",
          "storage": {
            "prefix": "Contracts",
            "items": [
              {
                "name": "CurrentSchedule",
                "modifier": "Default",
                "type": {"Plain": "Schedule"},
                "fallback":
                    "0x0000000020a107000000000020a107000000000098b23c000000000054923c000000000098033c00000000009241860000000000ecc33b0000000000ba1d3c00000000000a373c0000000000f2398d0000000000ea843b000000000098c73b0000000000f0586600000000000e471e0000000000f89b7f0000000000090100000000000068a95700000000009802000000000000e8a90c2a00000000a84a8e24000000003058af090000000068269e00000000001a88e4000000000004e1ea07000000002d090000000000003090a800000000006e6c601000000000bf07000000000000de22950a000000002cbb2a0200000000830500000000000078dd710b000000003e56cd07000000007c0c7c0a00000000ee01000000000000c802000000000000b49b0f1e00000000d205000000000000cd02000000000000886b3400000000000810000000000000fa05370000000000b40c000000000000e8b7320000000000b9050000000000003444320000000000b80500000000000000040000000000010010000000004000002000000000000800",
                "documentation": [" Current cost schedule for contracts."]
              },
              {
                "name": "PristineCode",
                "modifier": "Optional",
                "type": {
                  "Map": {
                    "hasher": "Identity",
                    "key": "CodeHash",
                    "value": "Bytes",
                    "linked": false
                  }
                },
                "fallback": "0x00",
                "documentation": [
                  " A mapping from an original code hash to the original code, untouched by instrumentation."
                ]
              },
              {
                "name": "CodeStorage",
                "modifier": "Optional",
                "type": {
                  "Map": {
                    "hasher": "Identity",
                    "key": "CodeHash",
                    "value": "PrefabWasmModule",
                    "linked": false
                  }
                },
                "fallback": "0x00",
                "documentation": [
                  " A mapping between an original code hash and instrumented wasm code, ready for execution."
                ]
              },
              {
                "name": "AccountCounter",
                "modifier": "Default",
                "type": {"Plain": "u64"},
                "fallback": "0x0000000000000000",
                "documentation": [" The subtrie counter."]
              },
              {
                "name": "ContractInfoOf",
                "modifier": "Optional",
                "type": {
                  "Map": {
                    "hasher": "Twox64Concat",
                    "key": "AccountId",
                    "value": "ContractInfo",
                    "linked": false
                  }
                },
                "fallback": "0x00",
                "documentation": [
                  " The code associated with a given account.",
                  "",
                  " TWOX-NOTE: SAFE since `AccountId` is a secure hash."
                ]
              }
            ]
          },
          "calls": [
            {
              "name": "update_schedule",
              "args": [
                {"name": "schedule", "type": "Schedule"}
              ],
              "documentation": [
                " Updates the schedule for metering contracts.",
                "",
                " The schedule must have a greater version than the stored schedule."
              ]
            },
            {
              "name": "put_code",
              "args": [
                {"name": "code", "type": "Bytes"}
              ],
              "documentation": [
                " Stores the given binary Wasm code into the chain's storage and returns its `codehash`.",
                " You can instantiate contracts only with stored code."
              ]
            },
            {
              "name": "call",
              "args": [
                {"name": "dest", "type": "LookupSource"},
                {"name": "value", "type": "Compact<BalanceOf>"},
                {"name": "gas_limit", "type": "Compact<Gas>"},
                {"name": "data", "type": "Bytes"}
              ],
              "documentation": [
                " Makes a call to an account, optionally transferring some balance.",
                "",
                " * If the account is a smart-contract account, the associated code will be",
                " executed and any value will be transferred.",
                " * If the account is a regular account, any value will be transferred.",
                " * If no account exists and the call value is not less than `existential_deposit`,",
                " a regular account will be created and any value will be transferred."
              ]
            },
            {
              "name": "instantiate",
              "args": [
                {"name": "endowment", "type": "Compact<BalanceOf>"},
                {"name": "gas_limit", "type": "Compact<Gas>"},
                {"name": "code_hash", "type": "CodeHash"},
                {"name": "data", "type": "Bytes"}
              ],
              "documentation": [
                " Instantiates a new contract from the `codehash` generated by `put_code`, optionally transferring some balance.",
                "",
                " Instantiation is executed as follows:",
                "",
                " - The destination address is computed based on the sender and hash of the code.",
                " - The smart-contract account is created at the computed address.",
                " - The `ctor_code` is executed in the context of the newly-created account. Buffer returned",
                "   after the execution is saved as the `code` of the account. That code will be invoked",
                "   upon any call received by this account.",
                " - The contract is initialized."
              ]
            },
            {
              "name": "claim_surcharge",
              "args": [
                {"name": "dest", "type": "AccountId"},
                {"name": "aux_sender", "type": "Option<AccountId>"}
              ],
              "documentation": [
                " Allows block producers to claim a small reward for evicting a contract. If a block producer",
                " fails to do so, a regular users will be allowed to claim the reward.",
                "",
                " If contract is not evicted as a result of this call, no actions are taken and",
                " the sender is not eligible for the reward."
              ]
            }
          ],
          "events": [
            {
              "name": "Instantiated",
              "args": ["AccountId", "AccountId"],
              "documentation": [
                " Contract deployed by address at the specified address. \\[owner, contract\\]"
              ]
            },
            {
              "name": "Evicted",
              "args": ["AccountId", "bool"],
              "documentation": [
                " Contract has been evicted and is now in tombstone state.",
                " \\[contract, tombstone\\]",
                "",
                " # Params",
                "",
                " - `contract`: `AccountId`: The account ID of the evicted contract.",
                " - `tombstone`: `bool`: True if the evicted contract left behind a tombstone."
              ]
            },
            {
              "name": "Restored",
              "args": ["AccountId", "AccountId", "Hash", "Balance"],
              "documentation": [
                " Restoration for a contract has been successful.",
                " \\[donor, dest, code_hash, rent_allowance\\]",
                "",
                " # Params",
                "",
                " - `donor`: `AccountId`: Account ID of the restoring contract",
                " - `dest`: `AccountId`: Account ID of the restored contract",
                " - `code_hash`: `Hash`: Code hash of the restored contract",
                " - `rent_allowance: `Balance`: Rent allowance of the restored contract"
              ]
            },
            {
              "name": "CodeStored",
              "args": ["Hash"],
              "documentation": [
                " Code with the specified hash has been stored.",
                " \\[code_hash\\]"
              ]
            },
            {
              "name": "ScheduleUpdated",
              "args": ["u32"],
              "documentation": [" Triggered when the current \\[schedule\\] is updated."]
            },
            {
              "name": "ContractExecution",
              "args": ["AccountId", "Bytes"],
              "documentation": [
                " An event deposited upon execution of a contract from the account.",
                " \\[account, data\\]"
              ]
            }
          ],
          "constants": [
            {
              "name": "SignedClaimHandicap",
              "type": "BlockNumber",
              "value": "0x02000000",
              "documentation": [
                " Number of block delay an extrinsic claim surcharge has.",
                "",
                " When claim surcharge is called by an extrinsic the rent is checked",
                " for current_block - delay"
              ]
            },
            {
              "name": "TombstoneDeposit",
              "type": "BalanceOf",
              "value": "0x00a0acb9030000000000000000000000",
              "documentation": [" The minimum amount required to generate a tombstone."]
            },
            {
              "name": "StorageSizeOffset",
              "type": "u32",
              "value": "0x08000000",
              "documentation": [
                " A size offset for an contract. A just created account with untouched storage will have that",
                " much of storage from the perspective of the state rent.",
                "",
                " This is a simple way to ensure that contracts with empty storage eventually get deleted",
                " by making them pay rent. This creates an incentive to remove them early in order to save",
                " rent."
              ]
            },
            {
              "name": "RentByteFee",
              "type": "BalanceOf",
              "value": "0x00286bee000000000000000000000000",
              "documentation": [
                " Price of a byte of storage per one block interval. Should be greater than 0."
              ]
            },
            {
              "name": "RentDepositOffset",
              "type": "BalanceOf",
              "value": "0x0010a5d4e80000000000000000000000",
              "documentation": [
                " The amount of funds a contract should deposit in order to offset",
                " the cost of one byte.",
                "",
                " Let's suppose the deposit is 1,000 BU (balance units)/byte and the rent is 1 BU/byte/day,",
                " then a contract with 1,000,000 BU that uses 1,000 bytes of storage would pay no rent.",
                " But if the balance reduced to 500,000 BU and the storage stayed the same at 1,000,",
                " then it would pay 500 BU/day."
              ]
            },
            {
              "name": "SurchargeReward",
              "type": "BalanceOf",
              "value": "0x005cb2ec220000000000000000000000",
              "documentation": [
                " Reward that is received by the party whose touch has led",
                " to removal of a contract."
              ]
            },
            {
              "name": "MaxDepth",
              "type": "u32",
              "value": "0x20000000",
              "documentation": [
                " The maximum nesting level of a call/instantiate stack. A reasonable default",
                " value is 100."
              ]
            },
            {
              "name": "MaxValueSize",
              "type": "u32",
              "value": "0x00400000",
              "documentation": [
                " The maximum size of a storage value in bytes. A reasonable default is 16 KiB."
              ]
            }
          ],
          "errors": [
            {
              "name": "InvalidScheduleVersion",
              "documentation": [" A new schedule must have a greater version than the current one."]
            },
            {
              "name": "InvalidSurchargeClaim",
              "documentation": [
                " An origin must be signed or inherent and auxiliary sender only provided on inherent."
              ]
            },
            {
              "name": "InvalidSourceContract",
              "documentation": [" Cannot restore from nonexisting or tombstone contract."]
            },
            {
              "name": "InvalidDestinationContract",
              "documentation": [" Cannot restore to nonexisting or alive contract."]
            },
            {
              "name": "InvalidTombstone",
              "documentation": [" Tombstones don't match."]
            },
            {
              "name": "InvalidContractOrigin",
              "documentation": [" An origin TrieId written in the current block."]
            },
            {
              "name": "OutOfGas",
              "documentation": [" The executed contract exhausted its gas limit."]
            },
            {
              "name": "OutputBufferTooSmall",
              "documentation": [" The output buffer supplied to a contract API call was too small."]
            },
            {
              "name": "BelowSubsistenceThreshold",
              "documentation": [
                " Performing the requested transfer would have brought the contract below",
                " the subsistence threshold. No transfer is allowed to do this in order to allow",
                " for a tombstone to be created. Use `seal_terminate` to remove a contract without",
                " leaving a tombstone behind."
              ]
            },
            {
              "name": "NewContractNotFunded",
              "documentation": [
                " The newly created contract is below the subsistence threshold after executing",
                " its contructor. No contracts are allowed to exist below that threshold."
              ]
            },
            {
              "name": "TransferFailed",
              "documentation": [
                " Performing the requested transfer failed for a reason originating in the",
                " chosen currency implementation of the runtime. Most probably the balance is",
                " too low or locks are placed on it."
              ]
            },
            {
              "name": "MaxCallDepthReached",
              "documentation": [
                " Performing a call was denied because the calling depth reached the limit",
                " of what is specified in the schedule."
              ]
            },
            {
              "name": "NotCallable",
              "documentation": [
                " The contract that was called is either no contract at all (a plain account)",
                " or is a tombstone."
              ]
            },
            {
              "name": "CodeTooLarge",
              "documentation": [
                " The code supplied to `put_code` exceeds the limit specified in the current schedule."
              ]
            },
            {
              "name": "CodeNotFound",
              "documentation": [" No code could be found at the supplied code hash."]
            },
            {
              "name": "OutOfBounds",
              "documentation": [
                " A buffer outside of sandbox memory was passed to a contract API function."
              ]
            },
            {
              "name": "DecodingFailed",
              "documentation": [
                " Input passed to a contract API function failed to decode as expected type."
              ]
            },
            {
              "name": "ContractTrapped",
              "documentation": [" Contract trapped during execution."]
            },
            {
              "name": "ValueTooLarge",
              "documentation": [" The size defined in `T::MaxValueSize` was exceeded."]
            }
          ],
          "index": 17
        },
        {
          "name": "Sudo",
          "storage": {
            "prefix": "Sudo",
            "items": [
              {
                "name": "Key",
                "modifier": "Default",
                "type": {"Plain": "AccountId"},
                "fallback": "0x0000000000000000000000000000000000000000000000000000000000000000",
                "documentation": [" The `AccountId` of the sudo key."]
              }
            ]
          },
          "calls": [
            {
              "name": "sudo",
              "args": [
                {"name": "call", "type": "Call"}
              ],
              "documentation": [
                " Authenticates the sudo key and dispatches a function call with `Root` origin.",
                "",
                " The dispatch origin for this call must be _Signed_.",
                "",
                " # <weight>",
                " - O(1).",
                " - Limited storage reads.",
                " - One DB write (event).",
                " - Weight of derivative `call` execution + 10,000.",
                " # </weight>"
              ]
            },
            {
              "name": "sudo_unchecked_weight",
              "args": [
                {"name": "call", "type": "Call"},
                {"name": "_weight", "type": "Weight"}
              ],
              "documentation": [
                " Authenticates the sudo key and dispatches a function call with `Root` origin.",
                " This function does not check the weight of the call, and instead allows the",
                " Sudo user to specify the weight of the call.",
                "",
                " The dispatch origin for this call must be _Signed_.",
                "",
                " # <weight>",
                " - O(1).",
                " - The weight of this call is defined by the caller.",
                " # </weight>"
              ]
            },
            {
              "name": "set_key",
              "args": [
                {"name": "new", "type": "LookupSource"}
              ],
              "documentation": [
                " Authenticates the current sudo key and sets the given AccountId (`new`) as the new sudo key.",
                "",
                " The dispatch origin for this call must be _Signed_.",
                "",
                " # <weight>",
                " - O(1).",
                " - Limited storage reads.",
                " - One DB change.",
                " # </weight>"
              ]
            },
            {
              "name": "sudo_as",
              "args": [
                {"name": "who", "type": "LookupSource"},
                {"name": "call", "type": "Call"}
              ],
              "documentation": [
                " Authenticates the sudo key and dispatches a function call with `Signed` origin from",
                " a given account.",
                "",
                " The dispatch origin for this call must be _Signed_.",
                "",
                " # <weight>",
                " - O(1).",
                " - Limited storage reads.",
                " - One DB write (event).",
                " - Weight of derivative `call` execution + 10,000.",
                " # </weight>"
              ]
            }
          ],
          "events": [
            {
              "name": "Sudid",
              "args": ["DispatchResult"],
              "documentation": [" A sudo just took place. \\[result\\]"]
            },
            {
              "name": "KeyChanged",
              "args": ["AccountId"],
              "documentation": [
                " The \\[sudoer\\] just switched identity; the old key is supplied."
              ]
            },
            {
              "name": "SudoAsDone",
              "args": ["bool"],
              "documentation": [" A sudo just took place. \\[result\\]"]
            }
          ],
          "constants": [],
          "errors": [
            {
              "name": "RequireSudo",
              "documentation": [" Sender must be the Sudo account"]
            }
          ],
          "index": 18
        },
        {
          "name": "ImOnline",
          "storage": {
            "prefix": "ImOnline",
            "items": [
              {
                "name": "HeartbeatAfter",
                "modifier": "Default",
                "type": {"Plain": "BlockNumber"},
                "fallback": "0x00000000",
                "documentation": [
                  " The block number after which it's ok to send heartbeats in current session.",
                  "",
                  " At the beginning of each session we set this to a value that should",
                  " fall roughly in the middle of the session duration.",
                  " The idea is to first wait for the validators to produce a block",
                  " in the current session, so that the heartbeat later on will not be necessary."
                ]
              },
              {
                "name": "Keys",
                "modifier": "Default",
                "type": {"Plain": "Vec<AuthorityId>"},
                "fallback": "0x00",
                "documentation": [" The current set of keys that may issue a heartbeat."]
              },
              {
                "name": "ReceivedHeartbeats",
                "modifier": "Optional",
                "type": {
                  "DoubleMap": {
                    "hasher": "Twox64Concat",
                    "key1": "SessionIndex",
                    "key2": "AuthIndex",
                    "value": "Bytes",
                    "key2Hasher": "Twox64Concat"
                  }
                },
                "fallback": "0x00",
                "documentation": [
                  " For each session index, we keep a mapping of `AuthIndex` to",
                  " `offchain::OpaqueNetworkState`."
                ]
              },
              {
                "name": "AuthoredBlocks",
                "modifier": "Default",
                "type": {
                  "DoubleMap": {
                    "hasher": "Twox64Concat",
                    "key1": "SessionIndex",
                    "key2": "ValidatorId",
                    "value": "u32",
                    "key2Hasher": "Twox64Concat"
                  }
                },
                "fallback": "0x00000000",
                "documentation": [
                  " For each session index, we keep a mapping of `T::ValidatorId` to the",
                  " number of blocks authored by the given authority."
                ]
              }
            ]
          },
          "calls": [
            {
              "name": "heartbeat",
              "args": [
                {"name": "heartbeat", "type": "Heartbeat"},
                {"name": "_signature", "type": "Signature"}
              ],
              "documentation": [
                " # <weight>",
                " - Complexity: `O(K + E)` where K is length of `Keys` (heartbeat.validators_len)",
                "   and E is length of `heartbeat.network_state.external_address`",
                "   - `O(K)`: decoding of length `K`",
                "   - `O(E)`: decoding/encoding of length `E`",
                " - DbReads: pallet_session `Validators`, pallet_session `CurrentIndex`, `Keys`,",
                "   `ReceivedHeartbeats`",
                " - DbWrites: `ReceivedHeartbeats`",
                " # </weight>"
              ]
            }
          ],
          "events": [
            {
              "name": "HeartbeatReceived",
              "args": ["AuthorityId"],
              "documentation": [
                " A new heartbeat was received from `AuthorityId` \\[authority_id\\]"
              ]
            },
            {
              "name": "AllGood",
              "args": [],
              "documentation": [" At the end of the session, no offence was committed."]
            },
            {
              "name": "SomeOffline",
              "args": ["Vec<IdentificationTuple>"],
              "documentation": [
                " At the end of the session, at least one validator was found to be \\[offline\\]."
              ]
            }
          ],
          "constants": [],
          "errors": [
            {
              "name": "InvalidKey",
              "documentation": [" Non existent public key."]
            },
            {
              "name": "DuplicatedHeartbeat",
              "documentation": [" Duplicated heartbeat."]
            }
          ],
          "index": 19
        },
        {
          "name": "AuthorityDiscovery",
          "storage": null,
          "calls": [],
          "events": null,
          "constants": [],
          "errors": [],
          "index": 20
        },
        {
          "name": "Offences",
          "storage": {
            "prefix": "Offences",
            "items": [
              {
                "name": "Reports",
                "modifier": "Optional",
                "type": {
                  "Map": {
                    "hasher": "Twox64Concat",
                    "key": "ReportIdOf",
                    "value": "OffenceDetails",
                    "linked": false
                  }
                },
                "fallback": "0x00",
                "documentation": [
                  " The primary structure that holds all offence records keyed by report identifiers."
                ]
              },
              {
                "name": "DeferredOffences",
                "modifier": "Default",
                "type": {"Plain": "Vec<DeferredOffenceOf>"},
                "fallback": "0x00",
                "documentation": [
                  " Deferred reports that have been rejected by the offence handler and need to be submitted",
                  " at a later time."
                ]
              },
              {
                "name": "ConcurrentReportsIndex",
                "modifier": "Default",
                "type": {
                  "DoubleMap": {
                    "hasher": "Twox64Concat",
                    "key1": "Kind",
                    "key2": "OpaqueTimeSlot",
                    "value": "Vec<ReportIdOf>",
                    "key2Hasher": "Twox64Concat"
                  }
                },
                "fallback": "0x00",
                "documentation": [
                  " A vector of reports of the same kind that happened at the same time slot."
                ]
              },
              {
                "name": "ReportsByKindIndex",
                "modifier": "Default",
                "type": {
                  "Map": {
                    "hasher": "Twox64Concat",
                    "key": "Kind",
                    "value": "Bytes",
                    "linked": false
                  }
                },
                "fallback": "0x00",
                "documentation": [
                  " Enumerates all reports of a kind along with the time they happened.",
                  "",
                  " All reports are sorted by the time of offence.",
                  "",
                  " Note that the actual type of this mapping is `Vec<u8>`, this is because values of",
                  " different types are not supported at the moment so we are doing the manual serialization."
                ]
              }
            ]
          },
          "calls": [],
          "events": [
            {
              "name": "Offence",
              "args": ["Kind", "OpaqueTimeSlot", "bool"],
              "documentation": [
                " There is an offence reported of the given `kind` happened at the `session_index` and",
                " (kind-specific) time slot. This event is not deposited for duplicate slashes. last",
                " element indicates of the offence was applied (true) or queued (false)",
                " \\[kind, timeslot, applied\\]."
              ]
            }
          ],
          "constants": [],
          "errors": [],
          "index": 21
        },
        {
          "name": "Historical",
          "storage": null,
          "calls": null,
          "events": null,
          "constants": [],
          "errors": [],
          "index": 22
        },
        {
          "name": "RandomnessCollectiveFlip",
          "storage": {
            "prefix": "RandomnessCollectiveFlip",
            "items": [
              {
                "name": "RandomMaterial",
                "modifier": "Default",
                "type": {"Plain": "Vec<Hash>"},
                "fallback": "0x00",
                "documentation": [
                  " Series of block headers from the last 81 blocks that acts as random seed material. This",
                  " is arranged as a ring buffer with `block_number % 81` being the index into the `Vec` of",
                  " the oldest hash."
                ]
              }
            ]
          },
          "calls": [],
          "events": null,
          "constants": [],
          "errors": [],
          "index": 23
        },
        {
          "name": "Identity",
          "storage": {
            "prefix": "Identity",
            "items": [
              {
                "name": "IdentityOf",
                "modifier": "Optional",
                "type": {
                  "Map": {
                    "hasher": "Twox64Concat",
                    "key": "AccountId",
                    "value": "Registration",
                    "linked": false
                  }
                },
                "fallback": "0x00",
                "documentation": [
                  " Information that is pertinent to identify the entity behind an account.",
                  "",
                  " TWOX-NOTE: OK ― `AccountId` is a secure hash."
                ]
              },
              {
                "name": "SuperOf",
                "modifier": "Optional",
                "type": {
                  "Map": {
                    "hasher": "Blake2_128Concat",
                    "key": "AccountId",
                    "value": "(AccountId,Data)",
                    "linked": false
                  }
                },
                "fallback": "0x00",
                "documentation": [
                  " The super-identity of an alternative \"sub\" identity together with its name, within that",
                  " context. If the account is not some other account's sub-identity, then just `None`."
                ]
              },
              {
                "name": "SubsOf",
                "modifier": "Default",
                "type": {
                  "Map": {
                    "hasher": "Twox64Concat",
                    "key": "AccountId",
                    "value": "(BalanceOf,Vec<AccountId>)",
                    "linked": false
                  }
                },
                "fallback": "0x0000000000000000000000000000000000",
                "documentation": [
                  " Alternative \"sub\" identities of this account.",
                  "",
                  " The first item is the deposit, the second is a vector of the accounts.",
                  "",
                  " TWOX-NOTE: OK ― `AccountId` is a secure hash."
                ]
              },
              {
                "name": "Registrars",
                "modifier": "Default",
                "type": {"Plain": "Vec<Option<RegistrarInfo>>"},
                "fallback": "0x00",
                "documentation": [
                  " The set of registrars. Not expected to get very big as can only be added through a",
                  " special origin (likely a council motion).",
                  "",
                  " The index into this can be cast to `RegistrarIndex` to get a valid value."
                ]
              }
            ]
          },
          "calls": [
            {
              "name": "add_registrar",
              "args": [
                {"name": "account", "type": "AccountId"}
              ],
              "documentation": [
                " Add a registrar to the system.",
                "",
                " The dispatch origin for this call must be `T::RegistrarOrigin`.",
                "",
                " - `account`: the account of the registrar.",
                "",
                " Emits `RegistrarAdded` if successful.",
                "",
                " # <weight>",
                " - `O(R)` where `R` registrar-count (governance-bounded and code-bounded).",
                " - One storage mutation (codec `O(R)`).",
                " - One event.",
                " # </weight>"
              ]
            },
            {
              "name": "set_identity",
              "args": [
                {"name": "info", "type": "IdentityInfo"}
              ],
              "documentation": [
                " Set an account's identity information and reserve the appropriate deposit.",
                "",
                " If the account already has identity information, the deposit is taken as part payment",
                " for the new deposit.",
                "",
                " The dispatch origin for this call must be _Signed_.",
                "",
                " - `info`: The identity information.",
                "",
                " Emits `IdentitySet` if successful.",
                "",
                " # <weight>",
                " - `O(X + X' + R)`",
                "   - where `X` additional-field-count (deposit-bounded and code-bounded)",
                "   - where `R` judgements-count (registrar-count-bounded)",
                " - One balance reserve operation.",
                " - One storage mutation (codec-read `O(X' + R)`, codec-write `O(X + R)`).",
                " - One event.",
                " # </weight>"
              ]
            },
            {
              "name": "set_subs",
              "args": [
                {"name": "subs", "type": "Vec<(AccountId,Data)>"}
              ],
              "documentation": [
                " Set the sub-accounts of the sender.",
                "",
                " Payment: Any aggregate balance reserved by previous `set_subs` calls will be returned",
                " and an amount `SubAccountDeposit` will be reserved for each item in `subs`.",
                "",
                " The dispatch origin for this call must be _Signed_ and the sender must have a registered",
                " identity.",
                "",
                " - `subs`: The identity's (new) sub-accounts.",
                "",
                " # <weight>",
                " - `O(P + S)`",
                "   - where `P` old-subs-count (hard- and deposit-bounded).",
                "   - where `S` subs-count (hard- and deposit-bounded).",
                " - At most one balance operations.",
                " - DB:",
                "   - `P + S` storage mutations (codec complexity `O(1)`)",
                "   - One storage read (codec complexity `O(P)`).",
                "   - One storage write (codec complexity `O(S)`).",
                "   - One storage-exists (`IdentityOf::contains_key`).",
                " # </weight>"
              ]
            },
            {
              "name": "clear_identity",
              "args": [],
              "documentation": [
                " Clear an account's identity info and all sub-accounts and return all deposits.",
                "",
                " Payment: All reserved balances on the account are returned.",
                "",
                " The dispatch origin for this call must be _Signed_ and the sender must have a registered",
                " identity.",
                "",
                " Emits `IdentityCleared` if successful.",
                "",
                " # <weight>",
                " - `O(R + S + X)`",
                "   - where `R` registrar-count (governance-bounded).",
                "   - where `S` subs-count (hard- and deposit-bounded).",
                "   - where `X` additional-field-count (deposit-bounded and code-bounded).",
                " - One balance-unreserve operation.",
                " - `2` storage reads and `S + 2` storage deletions.",
                " - One event.",
                " # </weight>"
              ]
            },
            {
              "name": "request_judgement",
              "args": [
                {"name": "reg_index", "type": "Compact<RegistrarIndex>"},
                {"name": "max_fee", "type": "Compact<BalanceOf>"}
              ],
              "documentation": [
                " Request a judgement from a registrar.",
                "",
                " Payment: At most `max_fee` will be reserved for payment to the registrar if judgement",
                " given.",
                "",
                " The dispatch origin for this call must be _Signed_ and the sender must have a",
                " registered identity.",
                "",
                " - `reg_index`: The index of the registrar whose judgement is requested.",
                " - `max_fee`: The maximum fee that may be paid. This should just be auto-populated as:",
                "",
                " ```nocompile",
                " Self::registrars().get(reg_index).unwrap().fee",
                " ```",
                "",
                " Emits `JudgementRequested` if successful.",
                "",
                " # <weight>",
                " - `O(R + X)`.",
                " - One balance-reserve operation.",
                " - Storage: 1 read `O(R)`, 1 mutate `O(X + R)`.",
                " - One event.",
                " # </weight>"
              ]
            },
            {
              "name": "cancel_request",
              "args": [
                {"name": "reg_index", "type": "RegistrarIndex"}
              ],
              "documentation": [
                " Cancel a previous request.",
                "",
                " Payment: A previously reserved deposit is returned on success.",
                "",
                " The dispatch origin for this call must be _Signed_ and the sender must have a",
                " registered identity.",
                "",
                " - `reg_index`: The index of the registrar whose judgement is no longer requested.",
                "",
                " Emits `JudgementUnrequested` if successful.",
                "",
                " # <weight>",
                " - `O(R + X)`.",
                " - One balance-reserve operation.",
                " - One storage mutation `O(R + X)`.",
                " - One event",
                " # </weight>"
              ]
            },
            {
              "name": "set_fee",
              "args": [
                {"name": "index", "type": "Compact<RegistrarIndex>"},
                {"name": "fee", "type": "Compact<BalanceOf>"}
              ],
              "documentation": [
                " Set the fee required for a judgement to be requested from a registrar.",
                "",
                " The dispatch origin for this call must be _Signed_ and the sender must be the account",
                " of the registrar whose index is `index`.",
                "",
                " - `index`: the index of the registrar whose fee is to be set.",
                " - `fee`: the new fee.",
                "",
                " # <weight>",
                " - `O(R)`.",
                " - One storage mutation `O(R)`.",
                " - Benchmark: 7.315 + R * 0.329 µs (min squares analysis)",
                " # </weight>"
              ]
            },
            {
              "name": "set_account_id",
              "args": [
                {"name": "index", "type": "Compact<RegistrarIndex>"},
                {"name": "new", "type": "AccountId"}
              ],
              "documentation": [
                " Change the account associated with a registrar.",
                "",
                " The dispatch origin for this call must be _Signed_ and the sender must be the account",
                " of the registrar whose index is `index`.",
                "",
                " - `index`: the index of the registrar whose fee is to be set.",
                " - `new`: the new account ID.",
                "",
                " # <weight>",
                " - `O(R)`.",
                " - One storage mutation `O(R)`.",
                " - Benchmark: 8.823 + R * 0.32 µs (min squares analysis)",
                " # </weight>"
              ]
            },
            {
              "name": "set_fields",
              "args": [
                {"name": "index", "type": "Compact<RegistrarIndex>"},
                {"name": "fields", "type": "IdentityFields"}
              ],
              "documentation": [
                " Set the field information for a registrar.",
                "",
                " The dispatch origin for this call must be _Signed_ and the sender must be the account",
                " of the registrar whose index is `index`.",
                "",
                " - `index`: the index of the registrar whose fee is to be set.",
                " - `fields`: the fields that the registrar concerns themselves with.",
                "",
                " # <weight>",
                " - `O(R)`.",
                " - One storage mutation `O(R)`.",
                " - Benchmark: 7.464 + R * 0.325 µs (min squares analysis)",
                " # </weight>"
              ]
            },
            {
              "name": "provide_judgement",
              "args": [
                {"name": "reg_index", "type": "Compact<RegistrarIndex>"},
                {"name": "target", "type": "LookupSource"},
                {"name": "judgement", "type": "IdentityJudgement"}
              ],
              "documentation": [
                " Provide a judgement for an account's identity.",
                "",
                " The dispatch origin for this call must be _Signed_ and the sender must be the account",
                " of the registrar whose index is `reg_index`.",
                "",
                " - `reg_index`: the index of the registrar whose judgement is being made.",
                " - `target`: the account whose identity the judgement is upon. This must be an account",
                "   with a registered identity.",
                " - `judgement`: the judgement of the registrar of index `reg_index` about `target`.",
                "",
                " Emits `JudgementGiven` if successful.",
                "",
                " # <weight>",
                " - `O(R + X)`.",
                " - One balance-transfer operation.",
                " - Up to one account-lookup operation.",
                " - Storage: 1 read `O(R)`, 1 mutate `O(R + X)`.",
                " - One event.",
                " # </weight>"
              ]
            },
            {
              "name": "kill_identity",
              "args": [
                {"name": "target", "type": "LookupSource"}
              ],
              "documentation": [
                " Remove an account's identity and sub-account information and slash the deposits.",
                "",
                " Payment: Reserved balances from `set_subs` and `set_identity` are slashed and handled by",
                " `Slash`. Verification request deposits are not returned; they should be cancelled",
                " manually using `cancel_request`.",
                "",
                " The dispatch origin for this call must match `T::ForceOrigin`.",
                "",
                " - `target`: the account whose identity the judgement is upon. This must be an account",
                "   with a registered identity.",
                "",
                " Emits `IdentityKilled` if successful.",
                "",
                " # <weight>",
                " - `O(R + S + X)`.",
                " - One balance-reserve operation.",
                " - `S + 2` storage mutations.",
                " - One event.",
                " # </weight>"
              ]
            },
            {
              "name": "add_sub",
              "args": [
                {"name": "sub", "type": "LookupSource"},
                {"name": "data", "type": "Data"}
              ],
              "documentation": [
                " Add the given account to the sender's subs.",
                "",
                " Payment: Balance reserved by a previous `set_subs` call for one sub will be repatriated",
                " to the sender.",
                "",
                " The dispatch origin for this call must be _Signed_ and the sender must have a registered",
                " sub identity of `sub`."
              ]
            },
            {
              "name": "rename_sub",
              "args": [
                {"name": "sub", "type": "LookupSource"},
                {"name": "data", "type": "Data"}
              ],
              "documentation": [
                " Alter the associated name of the given sub-account.",
                "",
                " The dispatch origin for this call must be _Signed_ and the sender must have a registered",
                " sub identity of `sub`."
              ]
            },
            {
              "name": "remove_sub",
              "args": [
                {"name": "sub", "type": "LookupSource"}
              ],
              "documentation": [
                " Remove the given account from the sender's subs.",
                "",
                " Payment: Balance reserved by a previous `set_subs` call for one sub will be repatriated",
                " to the sender.",
                "",
                " The dispatch origin for this call must be _Signed_ and the sender must have a registered",
                " sub identity of `sub`."
              ]
            },
            {
              "name": "quit_sub",
              "args": [],
              "documentation": [
                " Remove the sender as a sub-account.",
                "",
                " Payment: Balance reserved by a previous `set_subs` call for one sub will be repatriated",
                " to the sender (*not* the original depositor).",
                "",
                " The dispatch origin for this call must be _Signed_ and the sender must have a registered",
                " super-identity.",
                "",
                " NOTE: This should not normally be used, but is provided in the case that the non-",
                " controller of an account is maliciously registered as a sub-account."
              ]
            }
          ],
          "events": [
            {
              "name": "IdentitySet",
              "args": ["AccountId"],
              "documentation": [
                " A name was set or reset (which will remove all judgements). \\[who\\]"
              ]
            },
            {
              "name": "IdentityCleared",
              "args": ["AccountId", "Balance"],
              "documentation": [
                " A name was cleared, and the given balance returned. \\[who, deposit\\]"
              ]
            },
            {
              "name": "IdentityKilled",
              "args": ["AccountId", "Balance"],
              "documentation": [
                " A name was removed and the given balance slashed. \\[who, deposit\\]"
              ]
            },
            {
              "name": "JudgementRequested",
              "args": ["AccountId", "RegistrarIndex"],
              "documentation": [
                " A judgement was asked from a registrar. \\[who, registrar_index\\]"
              ]
            },
            {
              "name": "JudgementUnrequested",
              "args": ["AccountId", "RegistrarIndex"],
              "documentation": [" A judgement request was retracted. \\[who, registrar_index\\]"]
            },
            {
              "name": "JudgementGiven",
              "args": ["AccountId", "RegistrarIndex"],
              "documentation": [
                " A judgement was given by a registrar. \\[target, registrar_index\\]"
              ]
            },
            {
              "name": "RegistrarAdded",
              "args": ["RegistrarIndex"],
              "documentation": [" A registrar was added. \\[registrar_index\\]"]
            },
            {
              "name": "SubIdentityAdded",
              "args": ["AccountId", "AccountId", "Balance"],
              "documentation": [
                " A sub-identity was added to an identity and the deposit paid. \\[sub, main, deposit\\]"
              ]
            },
            {
              "name": "SubIdentityRemoved",
              "args": ["AccountId", "AccountId", "Balance"],
              "documentation": [
                " A sub-identity was removed from an identity and the deposit freed.",
                " \\[sub, main, deposit\\]"
              ]
            },
            {
              "name": "SubIdentityRevoked",
              "args": ["AccountId", "AccountId", "Balance"],
              "documentation": [
                " A sub-identity was cleared, and the given deposit repatriated from the",
                " main identity account to the sub-identity account. \\[sub, main, deposit\\]"
              ]
            }
          ],
          "constants": [
            {
              "name": "BasicDeposit",
              "type": "BalanceOf",
              "value": "0x0080c6a47e8d03000000000000000000",
              "documentation": [" The amount held on deposit for a registered identity."]
            },
            {
              "name": "FieldDeposit",
              "type": "BalanceOf",
              "value": "0x00a031a95fe300000000000000000000",
              "documentation": [
                " The amount held on deposit per additional field for a registered identity."
              ]
            },
            {
              "name": "SubAccountDeposit",
              "type": "BalanceOf",
              "value": "0x0080f420e6b500000000000000000000",
              "documentation": [
                " The amount held on deposit for a registered subaccount. This should account for the fact",
                " that one storage item's value will increase by the size of an account ID, and there will be",
                " another trie item whose value is the size of an account ID plus 32 bytes."
              ]
            },
            {
              "name": "MaxSubAccounts",
              "type": "u32",
              "value": "0x64000000",
              "documentation": [
                " The maximum number of sub-accounts allowed per identified account."
              ]
            },
            {
              "name": "MaxAdditionalFields",
              "type": "u32",
              "value": "0x64000000",
              "documentation": [
                " Maximum number of additional fields that may be stored in an ID. Needed to bound the I/O",
                " required to access an identity, but can be pretty high."
              ]
            },
            {
              "name": "MaxRegistrars",
              "type": "u32",
              "value": "0x14000000",
              "documentation": [
                " Maxmimum number of registrars allowed in the system. Needed to bound the complexity",
                " of, e.g., updating judgements."
              ]
            }
          ],
          "errors": [
            {
              "name": "TooManySubAccounts",
              "documentation": [" Too many subs-accounts."]
            },
            {
              "name": "NotFound",
              "documentation": [" Account isn't found."]
            },
            {
              "name": "NotNamed",
              "documentation": [" Account isn't named."]
            },
            {
              "name": "EmptyIndex",
              "documentation": [" Empty index."]
            },
            {
              "name": "FeeChanged",
              "documentation": [" Fee is changed."]
            },
            {
              "name": "NoIdentity",
              "documentation": [" No identity found."]
            },
            {
              "name": "StickyJudgement",
              "documentation": [" Sticky judgement."]
            },
            {
              "name": "JudgementGiven",
              "documentation": [" Judgement given."]
            },
            {
              "name": "InvalidJudgement",
              "documentation": [" Invalid judgement."]
            },
            {
              "name": "InvalidIndex",
              "documentation": [" The index is invalid."]
            },
            {
              "name": "InvalidTarget",
              "documentation": [" The target is invalid."]
            },
            {
              "name": "TooManyFields",
              "documentation": [" Too many additional fields."]
            },
            {
              "name": "TooManyRegistrars",
              "documentation": [" Maximum amount of registrars reached. Cannot add any more."]
            },
            {
              "name": "AlreadyClaimed",
              "documentation": [" Account ID is already named."]
            },
            {
              "name": "NotSub",
              "documentation": [" Sender is not a sub-account."]
            },
            {
              "name": "NotOwned",
              "documentation": [" Sub-account isn't owned by sender."]
            }
          ],
          "index": 24
        },
        {
          "name": "Society",
          "storage": {
            "prefix": "Society",
            "items": [
              {
                "name": "Founder",
                "modifier": "Optional",
                "type": {"Plain": "AccountId"},
                "fallback": "0x00",
                "documentation": [" The first member."]
              },
              {
                "name": "Rules",
                "modifier": "Optional",
                "type": {"Plain": "Hash"},
                "fallback": "0x00",
                "documentation": [
                  " A hash of the rules of this society concerning membership. Can only be set once and",
                  " only by the founder."
                ]
              },
              {
                "name": "Candidates",
                "modifier": "Default",
                "type": {"Plain": "Vec<Bid>"},
                "fallback": "0x00",
                "documentation": [
                  " The current set of candidates; bidders that are attempting to become members."
                ]
              },
              {
                "name": "SuspendedCandidates",
                "modifier": "Optional",
                "type": {
                  "Map": {
                    "hasher": "Twox64Concat",
                    "key": "AccountId",
                    "value": "(BalanceOf,BidKind)",
                    "linked": false
                  }
                },
                "fallback": "0x00",
                "documentation": [" The set of suspended candidates."]
              },
              {
                "name": "Pot",
                "modifier": "Default",
                "type": {"Plain": "BalanceOf"},
                "fallback": "0x00000000000000000000000000000000",
                "documentation": [
                  " Amount of our account balance that is specifically for the next round's bid(s)."
                ]
              },
              {
                "name": "Head",
                "modifier": "Optional",
                "type": {"Plain": "AccountId"},
                "fallback": "0x00",
                "documentation": [" The most primary from the most recently approved members."]
              },
              {
                "name": "Members",
                "modifier": "Default",
                "type": {"Plain": "Vec<AccountId>"},
                "fallback": "0x00",
                "documentation": [" The current set of members, ordered."]
              },
              {
                "name": "SuspendedMembers",
                "modifier": "Default",
                "type": {
                  "Map": {
                    "hasher": "Twox64Concat",
                    "key": "AccountId",
                    "value": "bool",
                    "linked": false
                  }
                },
                "fallback": "0x00",
                "documentation": [" The set of suspended members."]
              },
              {
                "name": "Bids",
                "modifier": "Default",
                "type": {"Plain": "Vec<Bid>"},
                "fallback": "0x00",
                "documentation": [" The current bids, stored ordered by the value of the bid."]
              },
              {
                "name": "Vouching",
                "modifier": "Optional",
                "type": {
                  "Map": {
                    "hasher": "Twox64Concat",
                    "key": "AccountId",
                    "value": "VouchingStatus",
                    "linked": false
                  }
                },
                "fallback": "0x00",
                "documentation": [" Members currently vouching or banned from vouching again"]
              },
              {
                "name": "Payouts",
                "modifier": "Default",
                "type": {
                  "Map": {
                    "hasher": "Twox64Concat",
                    "key": "AccountId",
                    "value": "Vec<(BlockNumber,BalanceOf)>",
                    "linked": false
                  }
                },
                "fallback": "0x00",
                "documentation": [
                  " Pending payouts; ordered by block number, with the amount that should be paid out."
                ]
              },
              {
                "name": "Strikes",
                "modifier": "Default",
                "type": {
                  "Map": {
                    "hasher": "Twox64Concat",
                    "key": "AccountId",
                    "value": "StrikeCount",
                    "linked": false
                  }
                },
                "fallback": "0x00000000",
                "documentation": [" The ongoing number of losing votes cast by the member."]
              },
              {
                "name": "Votes",
                "modifier": "Optional",
                "type": {
                  "DoubleMap": {
                    "hasher": "Twox64Concat",
                    "key1": "AccountId",
                    "key2": "AccountId",
                    "value": "SocietyVote",
                    "key2Hasher": "Twox64Concat"
                  }
                },
                "fallback": "0x00",
                "documentation": [" Double map from Candidate -> Voter -> (Maybe) Vote."]
              },
              {
                "name": "Defender",
                "modifier": "Optional",
                "type": {"Plain": "AccountId"},
                "fallback": "0x00",
                "documentation": [" The defending member currently being challenged."]
              },
              {
                "name": "DefenderVotes",
                "modifier": "Optional",
                "type": {
                  "Map": {
                    "hasher": "Twox64Concat",
                    "key": "AccountId",
                    "value": "SocietyVote",
                    "linked": false
                  }
                },
                "fallback": "0x00",
                "documentation": [" Votes for the defender."]
              },
              {
                "name": "MaxMembers",
                "modifier": "Default",
                "type": {"Plain": "u32"},
                "fallback": "0x00000000",
                "documentation": [" The max number of members for the society at one time."]
              }
            ]
          },
          "calls": [
            {
              "name": "bid",
              "args": [
                {"name": "value", "type": "BalanceOf"}
              ],
              "documentation": [
                " A user outside of the society can make a bid for entry.",
                "",
                " Payment: `CandidateDeposit` will be reserved for making a bid. It is returned",
                " when the bid becomes a member, or if the bid calls `unbid`.",
                "",
                " The dispatch origin for this call must be _Signed_.",
                "",
                " Parameters:",
                " - `value`: A one time payment the bid would like to receive when joining the society.",
                "",
                " # <weight>",
                " Key: B (len of bids), C (len of candidates), M (len of members), X (balance reserve)",
                " - Storage Reads:",
                " \t- One storage read to check for suspended candidate. O(1)",
                " \t- One storage read to check for suspended member. O(1)",
                " \t- One storage read to retrieve all current bids. O(B)",
                " \t- One storage read to retrieve all current candidates. O(C)",
                " \t- One storage read to retrieve all members. O(M)",
                " - Storage Writes:",
                " \t- One storage mutate to add a new bid to the vector O(B) (TODO: possible optimization w/ read)",
                " \t- Up to one storage removal if bid.len() > MAX_BID_COUNT. O(1)",
                " - Notable Computation:",
                " \t- O(B + C + log M) search to check user is not already a part of society.",
                " \t- O(log B) search to insert the new bid sorted.",
                " - External Module Operations:",
                " \t- One balance reserve operation. O(X)",
                " \t- Up to one balance unreserve operation if bids.len() > MAX_BID_COUNT.",
                " - Events:",
                " \t- One event for new bid.",
                " \t- Up to one event for AutoUnbid if bid.len() > MAX_BID_COUNT.",
                "",
                " Total Complexity: O(M + B + C + logM + logB + X)",
                " # </weight>"
              ]
            },
            {
              "name": "unbid",
              "args": [
                {"name": "pos", "type": "u32"}
              ],
              "documentation": [
                " A bidder can remove their bid for entry into society.",
                " By doing so, they will have their candidate deposit returned or",
                " they will unvouch their voucher.",
                "",
                " Payment: The bid deposit is unreserved if the user made a bid.",
                "",
                " The dispatch origin for this call must be _Signed_ and a bidder.",
                "",
                " Parameters:",
                " - `pos`: Position in the `Bids` vector of the bid who wants to unbid.",
                "",
                " # <weight>",
                " Key: B (len of bids), X (balance unreserve)",
                " - One storage read and write to retrieve and update the bids. O(B)",
                " - Either one unreserve balance action O(X) or one vouching storage removal. O(1)",
                " - One event.",
                "",
                " Total Complexity: O(B + X)",
                " # </weight>"
              ]
            },
            {
              "name": "vouch",
              "args": [
                {"name": "who", "type": "AccountId"},
                {"name": "value", "type": "BalanceOf"},
                {"name": "tip", "type": "BalanceOf"}
              ],
              "documentation": [
                " As a member, vouch for someone to join society by placing a bid on their behalf.",
                "",
                " There is no deposit required to vouch for a new bid, but a member can only vouch for",
                " one bid at a time. If the bid becomes a suspended candidate and ultimately rejected by",
                " the suspension judgement origin, the member will be banned from vouching again.",
                "",
                " As a vouching member, you can claim a tip if the candidate is accepted. This tip will",
                " be paid as a portion of the reward the member will receive for joining the society.",
                "",
                " The dispatch origin for this call must be _Signed_ and a member.",
                "",
                " Parameters:",
                " - `who`: The user who you would like to vouch for.",
                " - `value`: The total reward to be paid between you and the candidate if they become",
                " a member in the society.",
                " - `tip`: Your cut of the total `value` payout when the candidate is inducted into",
                " the society. Tips larger than `value` will be saturated upon payout.",
                "",
                " # <weight>",
                " Key: B (len of bids), C (len of candidates), M (len of members)",
                " - Storage Reads:",
                " \t- One storage read to retrieve all members. O(M)",
                " \t- One storage read to check member is not already vouching. O(1)",
                " \t- One storage read to check for suspended candidate. O(1)",
                " \t- One storage read to check for suspended member. O(1)",
                " \t- One storage read to retrieve all current bids. O(B)",
                " \t- One storage read to retrieve all current candidates. O(C)",
                " - Storage Writes:",
                " \t- One storage write to insert vouching status to the member. O(1)",
                " \t- One storage mutate to add a new bid to the vector O(B) (TODO: possible optimization w/ read)",
                " \t- Up to one storage removal if bid.len() > MAX_BID_COUNT. O(1)",
                " - Notable Computation:",
                " \t- O(log M) search to check sender is a member.",
                " \t- O(B + C + log M) search to check user is not already a part of society.",
                " \t- O(log B) search to insert the new bid sorted.",
                " - External Module Operations:",
                " \t- One balance reserve operation. O(X)",
                " \t- Up to one balance unreserve operation if bids.len() > MAX_BID_COUNT.",
                " - Events:",
                " \t- One event for vouch.",
                " \t- Up to one event for AutoUnbid if bid.len() > MAX_BID_COUNT.",
                "",
                " Total Complexity: O(M + B + C + logM + logB + X)",
                " # </weight>"
              ]
            },
            {
              "name": "unvouch",
              "args": [
                {"name": "pos", "type": "u32"}
              ],
              "documentation": [
                " As a vouching member, unvouch a bid. This only works while vouched user is",
                " only a bidder (and not a candidate).",
                "",
                " The dispatch origin for this call must be _Signed_ and a vouching member.",
                "",
                " Parameters:",
                " - `pos`: Position in the `Bids` vector of the bid who should be unvouched.",
                "",
                " # <weight>",
                " Key: B (len of bids)",
                " - One storage read O(1) to check the signer is a vouching member.",
                " - One storage mutate to retrieve and update the bids. O(B)",
                " - One vouching storage removal. O(1)",
                " - One event.",
                "",
                " Total Complexity: O(B)",
                " # </weight>"
              ]
            },
            {
              "name": "vote",
              "args": [
                {"name": "candidate", "type": "LookupSource"},
                {"name": "approve", "type": "bool"}
              ],
              "documentation": [
                " As a member, vote on a candidate.",
                "",
                " The dispatch origin for this call must be _Signed_ and a member.",
                "",
                " Parameters:",
                " - `candidate`: The candidate that the member would like to bid on.",
                " - `approve`: A boolean which says if the candidate should be",
                "              approved (`true`) or rejected (`false`).",
                "",
                " # <weight>",
                " Key: C (len of candidates), M (len of members)",
                " - One storage read O(M) and O(log M) search to check user is a member.",
                " - One account lookup.",
                " - One storage read O(C) and O(C) search to check that user is a candidate.",
                " - One storage write to add vote to votes. O(1)",
                " - One event.",
                "",
                " Total Complexity: O(M + logM + C)",
                " # </weight>"
              ]
            },
            {
              "name": "defender_vote",
              "args": [
                {"name": "approve", "type": "bool"}
              ],
              "documentation": [
                " As a member, vote on the defender.",
                "",
                " The dispatch origin for this call must be _Signed_ and a member.",
                "",
                " Parameters:",
                " - `approve`: A boolean which says if the candidate should be",
                " approved (`true`) or rejected (`false`).",
                "",
                " # <weight>",
                " - Key: M (len of members)",
                " - One storage read O(M) and O(log M) search to check user is a member.",
                " - One storage write to add vote to votes. O(1)",
                " - One event.",
                "",
                " Total Complexity: O(M + logM)",
                " # </weight>"
              ]
            },
            {
              "name": "payout",
              "args": [],
              "documentation": [
                " Transfer the first matured payout for the sender and remove it from the records.",
                "",
                " NOTE: This extrinsic needs to be called multiple times to claim multiple matured payouts.",
                "",
                " Payment: The member will receive a payment equal to their first matured",
                " payout to their free balance.",
                "",
                " The dispatch origin for this call must be _Signed_ and a member with",
                " payouts remaining.",
                "",
                " # <weight>",
                " Key: M (len of members), P (number of payouts for a particular member)",
                " - One storage read O(M) and O(log M) search to check signer is a member.",
                " - One storage read O(P) to get all payouts for a member.",
                " - One storage read O(1) to get the current block number.",
                " - One currency transfer call. O(X)",
                " - One storage write or removal to update the member's payouts. O(P)",
                "",
                " Total Complexity: O(M + logM + P + X)",
                " # </weight>"
              ]
            },
            {
              "name": "found",
              "args": [
                {"name": "founder", "type": "AccountId"},
                {"name": "max_members", "type": "u32"},
                {"name": "rules", "type": "Bytes"}
              ],
              "documentation": [
                " Found the society.",
                "",
                " This is done as a discrete action in order to allow for the",
                " module to be included into a running chain and can only be done once.",
                "",
                " The dispatch origin for this call must be from the _FounderSetOrigin_.",
                "",
                " Parameters:",
                " - `founder` - The first member and head of the newly founded society.",
                " - `max_members` - The initial max number of members for the society.",
                " - `rules` - The rules of this society concerning membership.",
                "",
                " # <weight>",
                " - Two storage mutates to set `Head` and `Founder`. O(1)",
                " - One storage write to add the first member to society. O(1)",
                " - One event.",
                "",
                " Total Complexity: O(1)",
                " # </weight>"
              ]
            },
            {
              "name": "unfound",
              "args": [],
              "documentation": [
                " Annul the founding of the society.",
                "",
                " The dispatch origin for this call must be Signed, and the signing account must be both",
                " the `Founder` and the `Head`. This implies that it may only be done when there is one",
                " member.",
                "",
                " # <weight>",
                " - Two storage reads O(1).",
                " - Four storage removals O(1).",
                " - One event.",
                "",
                " Total Complexity: O(1)",
                " # </weight>"
              ]
            },
            {
              "name": "judge_suspended_member",
              "args": [
                {"name": "who", "type": "AccountId"},
                {"name": "forgive", "type": "bool"}
              ],
              "documentation": [
                " Allow suspension judgement origin to make judgement on a suspended member.",
                "",
                " If a suspended member is forgiven, we simply add them back as a member, not affecting",
                " any of the existing storage items for that member.",
                "",
                " If a suspended member is rejected, remove all associated storage items, including",
                " their payouts, and remove any vouched bids they currently have.",
                "",
                " The dispatch origin for this call must be from the _SuspensionJudgementOrigin_.",
                "",
                " Parameters:",
                " - `who` - The suspended member to be judged.",
                " - `forgive` - A boolean representing whether the suspension judgement origin",
                "               forgives (`true`) or rejects (`false`) a suspended member.",
                "",
                " # <weight>",
                " Key: B (len of bids), M (len of members)",
                " - One storage read to check `who` is a suspended member. O(1)",
                " - Up to one storage write O(M) with O(log M) binary search to add a member back to society.",
                " - Up to 3 storage removals O(1) to clean up a removed member.",
                " - Up to one storage write O(B) with O(B) search to remove vouched bid from bids.",
                " - Up to one additional event if unvouch takes place.",
                " - One storage removal. O(1)",
                " - One event for the judgement.",
                "",
                " Total Complexity: O(M + logM + B)",
                " # </weight>"
              ]
            },
            {
              "name": "judge_suspended_candidate",
              "args": [
                {"name": "who", "type": "AccountId"},
                {"name": "judgement", "type": "SocietyJudgement"}
              ],
              "documentation": [
                " Allow suspended judgement origin to make judgement on a suspended candidate.",
                "",
                " If the judgement is `Approve`, we add them to society as a member with the appropriate",
                " payment for joining society.",
                "",
                " If the judgement is `Reject`, we either slash the deposit of the bid, giving it back",
                " to the society treasury, or we ban the voucher from vouching again.",
                "",
                " If the judgement is `Rebid`, we put the candidate back in the bid pool and let them go",
                " through the induction process again.",
                "",
                " The dispatch origin for this call must be from the _SuspensionJudgementOrigin_.",
                "",
                " Parameters:",
                " - `who` - The suspended candidate to be judged.",
                " - `judgement` - `Approve`, `Reject`, or `Rebid`.",
                "",
                " # <weight>",
                " Key: B (len of bids), M (len of members), X (balance action)",
                " - One storage read to check `who` is a suspended candidate.",
                " - One storage removal of the suspended candidate.",
                " - Approve Logic",
                " \t- One storage read to get the available pot to pay users with. O(1)",
                " \t- One storage write to update the available pot. O(1)",
                " \t- One storage read to get the current block number. O(1)",
                " \t- One storage read to get all members. O(M)",
                " \t- Up to one unreserve currency action.",
                " \t- Up to two new storage writes to payouts.",
                " \t- Up to one storage write with O(log M) binary search to add a member to society.",
                " - Reject Logic",
                " \t- Up to one repatriate reserved currency action. O(X)",
                " \t- Up to one storage write to ban the vouching member from vouching again.",
                " - Rebid Logic",
                " \t- Storage mutate with O(log B) binary search to place the user back into bids.",
                " - Up to one additional event if unvouch takes place.",
                " - One storage removal.",
                " - One event for the judgement.",
                "",
                " Total Complexity: O(M + logM + B + X)",
                " # </weight>"
              ]
            },
            {
              "name": "set_max_members",
              "args": [
                {"name": "max", "type": "u32"}
              ],
              "documentation": [
                " Allows root origin to change the maximum number of members in society.",
                " Max membership count must be greater than 1.",
                "",
                " The dispatch origin for this call must be from _ROOT_.",
                "",
                " Parameters:",
                " - `max` - The maximum number of members for the society.",
                "",
                " # <weight>",
                " - One storage write to update the max. O(1)",
                " - One event.",
                "",
                " Total Complexity: O(1)",
                " # </weight>"
              ]
            }
          ],
          "events": [
            {
              "name": "Founded",
              "args": ["AccountId"],
              "documentation": [" The society is founded by the given identity. \\[founder\\]"]
            },
            {
              "name": "Bid",
              "args": ["AccountId", "Balance"],
              "documentation": [
                " A membership bid just happened. The given account is the candidate's ID and their offer",
                " is the second. \\[candidate_id, offer\\]"
              ]
            },
            {
              "name": "Vouch",
              "args": ["AccountId", "Balance", "AccountId"],
              "documentation": [
                " A membership bid just happened by vouching. The given account is the candidate's ID and",
                " their offer is the second. The vouching party is the third. \\[candidate_id, offer, vouching\\]"
              ]
            },
            {
              "name": "AutoUnbid",
              "args": ["AccountId"],
              "documentation": [
                " A \\[candidate\\] was dropped (due to an excess of bids in the system)."
              ]
            },
            {
              "name": "Unbid",
              "args": ["AccountId"],
              "documentation": [" A \\[candidate\\] was dropped (by their request)."]
            },
            {
              "name": "Unvouch",
              "args": ["AccountId"],
              "documentation": [
                " A \\[candidate\\] was dropped (by request of who vouched for them)."
              ]
            },
            {
              "name": "Inducted",
              "args": ["AccountId", "Vec<AccountId>"],
              "documentation": [
                " A group of candidates have been inducted. The batch's primary is the first value, the",
                " batch in full is the second. \\[primary, candidates\\]"
              ]
            },
            {
              "name": "SuspendedMemberJudgement",
              "args": ["AccountId", "bool"],
              "documentation": [" A suspended member has been judged. \\[who, judged\\]"]
            },
            {
              "name": "CandidateSuspended",
              "args": ["AccountId"],
              "documentation": [" A \\[candidate\\] has been suspended"]
            },
            {
              "name": "MemberSuspended",
              "args": ["AccountId"],
              "documentation": [" A \\[member\\] has been suspended"]
            },
            {
              "name": "Challenged",
              "args": ["AccountId"],
              "documentation": [" A \\[member\\] has been challenged"]
            },
            {
              "name": "Vote",
              "args": ["AccountId", "AccountId", "bool"],
              "documentation": [" A vote has been placed \\[candidate, voter, vote\\]"]
            },
            {
              "name": "DefenderVote",
              "args": ["AccountId", "bool"],
              "documentation": [" A vote has been placed for a defending member \\[voter, vote\\]"]
            },
            {
              "name": "NewMaxMembers",
              "args": ["u32"],
              "documentation": [" A new \\[max\\] member count has been set"]
            },
            {
              "name": "Unfounded",
              "args": ["AccountId"],
              "documentation": [" Society is unfounded. \\[founder\\]"]
            },
            {
              "name": "Deposit",
              "args": ["Balance"],
              "documentation": [" Some funds were deposited into the society account. \\[value\\]"]
            }
          ],
          "constants": [
            {
              "name": "CandidateDeposit",
              "type": "BalanceOf",
              "value": "0x0080c6a47e8d03000000000000000000",
              "documentation": [" The minimum amount of a deposit required for a bid to be made."]
            },
            {
              "name": "WrongSideDeduction",
              "type": "BalanceOf",
              "value": "0x0080f420e6b500000000000000000000",
              "documentation": [
                " The amount of the unpaid reward that gets deducted in the case that either a skeptic",
                " doesn't vote or someone votes in the wrong way."
              ]
            },
            {
              "name": "MaxStrikes",
              "type": "u32",
              "value": "0x0a000000",
              "documentation": [
                " The number of times a member may vote the wrong way (or not at all, when they are a skeptic)",
                " before they become suspended."
              ]
            },
            {
              "name": "PeriodSpend",
              "type": "BalanceOf",
              "value": "0x0000c52ebca2b1000000000000000000",
              "documentation": [
                " The amount of incentive paid within each period. Doesn't include VoterTip."
              ]
            },
            {
              "name": "RotationPeriod",
              "type": "BlockNumber",
              "value": "0x00770100",
              "documentation": [
                " The number of blocks between candidate/membership rotation periods."
              ]
            },
            {
              "name": "ChallengePeriod",
              "type": "BlockNumber",
              "value": "0x80130300",
              "documentation": [" The number of blocks between membership challenges."]
            },
            {
              "name": "ModuleId",
              "type": "ModuleId",
              "value": "0x70792f736f636965",
              "documentation": [" The societies's module id"]
            }
          ],
          "errors": [
            {
              "name": "BadPosition",
              "documentation": [" An incorrect position was provided."]
            },
            {
              "name": "NotMember",
              "documentation": [" User is not a member."]
            },
            {
              "name": "AlreadyMember",
              "documentation": [" User is already a member."]
            },
            {
              "name": "Suspended",
              "documentation": [" User is suspended."]
            },
            {
              "name": "NotSuspended",
              "documentation": [" User is not suspended."]
            },
            {
              "name": "NoPayout",
              "documentation": [" Nothing to payout."]
            },
            {
              "name": "AlreadyFounded",
              "documentation": [" Society already founded."]
            },
            {
              "name": "InsufficientPot",
              "documentation": [" Not enough in pot to accept candidate."]
            },
            {
              "name": "AlreadyVouching",
              "documentation": [" Member is already vouching or banned from vouching again."]
            },
            {
              "name": "NotVouching",
              "documentation": [" Member is not vouching."]
            },
            {
              "name": "Head",
              "documentation": [" Cannot remove the head of the chain."]
            },
            {
              "name": "Founder",
              "documentation": [" Cannot remove the founder."]
            },
            {
              "name": "AlreadyBid",
              "documentation": [" User has already made a bid."]
            },
            {
              "name": "AlreadyCandidate",
              "documentation": [" User is already a candidate."]
            },
            {
              "name": "NotCandidate",
              "documentation": [" User is not a candidate."]
            },
            {
              "name": "MaxMembers",
              "documentation": [" Too many members in the society."]
            },
            {
              "name": "NotFounder",
              "documentation": [" The caller is not the founder."]
            },
            {
              "name": "NotHead",
              "documentation": [" The caller is not the head."]
            }
          ],
          "index": 25
        },
        {
          "name": "Recovery",
          "storage": {
            "prefix": "Recovery",
            "items": [
              {
                "name": "Recoverable",
                "modifier": "Optional",
                "type": {
                  "Map": {
                    "hasher": "Twox64Concat",
                    "key": "AccountId",
                    "value": "RecoveryConfig",
                    "linked": false
                  }
                },
                "fallback": "0x00",
                "documentation": [
                  " The set of recoverable accounts and their recovery configuration."
                ]
              },
              {
                "name": "ActiveRecoveries",
                "modifier": "Optional",
                "type": {
                  "DoubleMap": {
                    "hasher": "Twox64Concat",
                    "key1": "AccountId",
                    "key2": "AccountId",
                    "value": "ActiveRecovery",
                    "key2Hasher": "Twox64Concat"
                  }
                },
                "fallback": "0x00",
                "documentation": [
                  " Active recovery attempts.",
                  "",
                  " First account is the account to be recovered, and the second account",
                  " is the user trying to recover the account."
                ]
              },
              {
                "name": "Proxy",
                "modifier": "Optional",
                "type": {
                  "Map": {
                    "hasher": "Blake2_128Concat",
                    "key": "AccountId",
                    "value": "AccountId",
                    "linked": false
                  }
                },
                "fallback": "0x00",
                "documentation": [
                  " The list of allowed proxy accounts.",
                  "",
                  " Map from the user who can access it to the recovered account."
                ]
              }
            ]
          },
          "calls": [
            {
              "name": "as_recovered",
              "args": [
                {"name": "account", "type": "AccountId"},
                {"name": "call", "type": "Call"}
              ],
              "documentation": [
                " Send a call through a recovered account.",
                "",
                " The dispatch origin for this call must be _Signed_ and registered to",
                " be able to make calls on behalf of the recovered account.",
                "",
                " Parameters:",
                " - `account`: The recovered account you want to make a call on-behalf-of.",
                " - `call`: The call you want to make with the recovered account.",
                "",
                " # <weight>",
                " - The weight of the `call` + 10,000.",
                " - One storage lookup to check account is recovered by `who`. O(1)",
                " # </weight>"
              ]
            },
            {
              "name": "set_recovered",
              "args": [
                {"name": "lost", "type": "AccountId"},
                {"name": "rescuer", "type": "AccountId"}
              ],
              "documentation": [
                " Allow ROOT to bypass the recovery process and set an a rescuer account",
                " for a lost account directly.",
                "",
                " The dispatch origin for this call must be _ROOT_.",
                "",
                " Parameters:",
                " - `lost`: The \"lost account\" to be recovered.",
                " - `rescuer`: The \"rescuer account\" which can call as the lost account.",
                "",
                " # <weight>",
                " - One storage write O(1)",
                " - One event",
                " # </weight>"
              ]
            },
            {
              "name": "create_recovery",
              "args": [
                {"name": "friends", "type": "Vec<AccountId>"},
                {"name": "threshold", "type": "u16"},
                {"name": "delay_period", "type": "BlockNumber"}
              ],
              "documentation": [
                " Create a recovery configuration for your account. This makes your account recoverable.",
                "",
                " Payment: `ConfigDepositBase` + `FriendDepositFactor` * #_of_friends balance",
                " will be reserved for storing the recovery configuration. This deposit is returned",
                " in full when the user calls `remove_recovery`.",
                "",
                " The dispatch origin for this call must be _Signed_.",
                "",
                " Parameters:",
                " - `friends`: A list of friends you trust to vouch for recovery attempts.",
                "   Should be ordered and contain no duplicate values.",
                " - `threshold`: The number of friends that must vouch for a recovery attempt",
                "   before the account can be recovered. Should be less than or equal to",
                "   the length of the list of friends.",
                " - `delay_period`: The number of blocks after a recovery attempt is initialized",
                "   that needs to pass before the account can be recovered.",
                "",
                " # <weight>",
                " - Key: F (len of friends)",
                " - One storage read to check that account is not already recoverable. O(1).",
                " - A check that the friends list is sorted and unique. O(F)",
                " - One currency reserve operation. O(X)",
                " - One storage write. O(1). Codec O(F).",
                " - One event.",
                "",
                " Total Complexity: O(F + X)",
                " # </weight>"
              ]
            },
            {
              "name": "initiate_recovery",
              "args": [
                {"name": "account", "type": "AccountId"}
              ],
              "documentation": [
                " Initiate the process for recovering a recoverable account.",
                "",
                " Payment: `RecoveryDeposit` balance will be reserved for initiating the",
                " recovery process. This deposit will always be repatriated to the account",
                " trying to be recovered. See `close_recovery`.",
                "",
                " The dispatch origin for this call must be _Signed_.",
                "",
                " Parameters:",
                " - `account`: The lost account that you want to recover. This account",
                "   needs to be recoverable (i.e. have a recovery configuration).",
                "",
                " # <weight>",
                " - One storage read to check that account is recoverable. O(F)",
                " - One storage read to check that this recovery process hasn't already started. O(1)",
                " - One currency reserve operation. O(X)",
                " - One storage read to get the current block number. O(1)",
                " - One storage write. O(1).",
                " - One event.",
                "",
                " Total Complexity: O(F + X)",
                " # </weight>"
              ]
            },
            {
              "name": "vouch_recovery",
              "args": [
                {"name": "lost", "type": "AccountId"},
                {"name": "rescuer", "type": "AccountId"}
              ],
              "documentation": [
                " Allow a \"friend\" of a recoverable account to vouch for an active recovery",
                " process for that account.",
                "",
                " The dispatch origin for this call must be _Signed_ and must be a \"friend\"",
                " for the recoverable account.",
                "",
                " Parameters:",
                " - `lost`: The lost account that you want to recover.",
                " - `rescuer`: The account trying to rescue the lost account that you",
                "   want to vouch for.",
                "",
                " The combination of these two parameters must point to an active recovery",
                " process.",
                "",
                " # <weight>",
                " Key: F (len of friends in config), V (len of vouching friends)",
                " - One storage read to get the recovery configuration. O(1), Codec O(F)",
                " - One storage read to get the active recovery process. O(1), Codec O(V)",
                " - One binary search to confirm caller is a friend. O(logF)",
                " - One binary search to confirm caller has not already vouched. O(logV)",
                " - One storage write. O(1), Codec O(V).",
                " - One event.",
                "",
                " Total Complexity: O(F + logF + V + logV)",
                " # </weight>"
              ]
            },
            {
              "name": "claim_recovery",
              "args": [
                {"name": "account", "type": "AccountId"}
              ],
              "documentation": [
                " Allow a successful rescuer to claim their recovered account.",
                "",
                " The dispatch origin for this call must be _Signed_ and must be a \"rescuer\"",
                " who has successfully completed the account recovery process: collected",
                " `threshold` or more vouches, waited `delay_period` blocks since initiation.",
                "",
                " Parameters:",
                " - `account`: The lost account that you want to claim has been successfully",
                "   recovered by you.",
                "",
                " # <weight>",
                " Key: F (len of friends in config), V (len of vouching friends)",
                " - One storage read to get the recovery configuration. O(1), Codec O(F)",
                " - One storage read to get the active recovery process. O(1), Codec O(V)",
                " - One storage read to get the current block number. O(1)",
                " - One storage write. O(1), Codec O(V).",
                " - One event.",
                "",
                " Total Complexity: O(F + V)",
                " # </weight>"
              ]
            },
            {
              "name": "close_recovery",
              "args": [
                {"name": "rescuer", "type": "AccountId"}
              ],
              "documentation": [
                " As the controller of a recoverable account, close an active recovery",
                " process for your account.",
                "",
                " Payment: By calling this function, the recoverable account will receive",
                " the recovery deposit `RecoveryDeposit` placed by the rescuer.",
                "",
                " The dispatch origin for this call must be _Signed_ and must be a",
                " recoverable account with an active recovery process for it.",
                "",
                " Parameters:",
                " - `rescuer`: The account trying to rescue this recoverable account.",
                "",
                " # <weight>",
                " Key: V (len of vouching friends)",
                " - One storage read/remove to get the active recovery process. O(1), Codec O(V)",
                " - One balance call to repatriate reserved. O(X)",
                " - One event.",
                "",
                " Total Complexity: O(V + X)",
                " # </weight>"
              ]
            },
            {
              "name": "remove_recovery",
              "args": [],
              "documentation": [
                " Remove the recovery process for your account. Recovered accounts are still accessible.",
                "",
                " NOTE: The user must make sure to call `close_recovery` on all active",
                " recovery attempts before calling this function else it will fail.",
                "",
                " Payment: By calling this function the recoverable account will unreserve",
                " their recovery configuration deposit.",
                " (`ConfigDepositBase` + `FriendDepositFactor` * #_of_friends)",
                "",
                " The dispatch origin for this call must be _Signed_ and must be a",
                " recoverable account (i.e. has a recovery configuration).",
                "",
                " # <weight>",
                " Key: F (len of friends)",
                " - One storage read to get the prefix iterator for active recoveries. O(1)",
                " - One storage read/remove to get the recovery configuration. O(1), Codec O(F)",
                " - One balance call to unreserved. O(X)",
                " - One event.",
                "",
                " Total Complexity: O(F + X)",
                " # </weight>"
              ]
            },
            {
              "name": "cancel_recovered",
              "args": [
                {"name": "account", "type": "AccountId"}
              ],
              "documentation": [
                " Cancel the ability to use `as_recovered` for `account`.",
                "",
                " The dispatch origin for this call must be _Signed_ and registered to",
                " be able to make calls on behalf of the recovered account.",
                "",
                " Parameters:",
                " - `account`: The recovered account you are able to call on-behalf-of.",
                "",
                " # <weight>",
                " - One storage mutation to check account is recovered by `who`. O(1)",
                " # </weight>"
              ]
            }
          ],
          "events": [
            {
              "name": "RecoveryCreated",
              "args": ["AccountId"],
              "documentation": [" A recovery process has been set up for an \\[account\\]."]
            },
            {
              "name": "RecoveryInitiated",
              "args": ["AccountId", "AccountId"],
              "documentation": [
                " A recovery process has been initiated for lost account by rescuer account.",
                " \\[lost, rescuer\\]"
              ]
            },
            {
              "name": "RecoveryVouched",
              "args": ["AccountId", "AccountId", "AccountId"],
              "documentation": [
                " A recovery process for lost account by rescuer account has been vouched for by sender.",
                " \\[lost, rescuer, sender\\]"
              ]
            },
            {
              "name": "RecoveryClosed",
              "args": ["AccountId", "AccountId"],
              "documentation": [
                " A recovery process for lost account by rescuer account has been closed.",
                " \\[lost, rescuer\\]"
              ]
            },
            {
              "name": "AccountRecovered",
              "args": ["AccountId", "AccountId"],
              "documentation": [
                " Lost account has been successfully recovered by rescuer account.",
                " \\[lost, rescuer\\]"
              ]
            },
            {
              "name": "RecoveryRemoved",
              "args": ["AccountId"],
              "documentation": [" A recovery process has been removed for an \\[account\\]."]
            }
          ],
          "constants": [
            {
              "name": "ConfigDepositBase",
              "type": "BalanceOf",
              "value": "0x00406352bfc601000000000000000000",
              "documentation": [
                " The base amount of currency needed to reserve for creating a recovery configuration."
              ]
            },
            {
              "name": "FriendDepositFactor",
              "type": "BalanceOf",
              "value": "0x00203d88792d00000000000000000000",
              "documentation": [
                " The amount of currency needed per additional user when creating a recovery configuration."
              ]
            },
            {
              "name": "MaxFriends",
              "type": "u16",
              "value": "0x0900",
              "documentation": [
                " The maximum amount of friends allowed in a recovery configuration."
              ]
            },
            {
              "name": "RecoveryDeposit",
              "type": "BalanceOf",
              "value": "0x00406352bfc601000000000000000000",
              "documentation": [
                " The base amount of currency needed to reserve for starting a recovery."
              ]
            }
          ],
          "errors": [
            {
              "name": "NotAllowed",
              "documentation": [" User is not allowed to make a call on behalf of this account"]
            },
            {
              "name": "ZeroThreshold",
              "documentation": [" Threshold must be greater than zero"]
            },
            {
              "name": "NotEnoughFriends",
              "documentation": [" Friends list must be greater than zero and threshold"]
            },
            {
              "name": "MaxFriends",
              "documentation": [" Friends list must be less than max friends"]
            },
            {
              "name": "NotSorted",
              "documentation": [" Friends list must be sorted and free of duplicates"]
            },
            {
              "name": "NotRecoverable",
              "documentation": [" This account is not set up for recovery"]
            },
            {
              "name": "AlreadyRecoverable",
              "documentation": [" This account is already set up for recovery"]
            },
            {
              "name": "AlreadyStarted",
              "documentation": [" A recovery process has already started for this account"]
            },
            {
              "name": "NotStarted",
              "documentation": [" A recovery process has not started for this rescuer"]
            },
            {
              "name": "NotFriend",
              "documentation": [" This account is not a friend who can vouch"]
            },
            {
              "name": "DelayPeriod",
              "documentation": [
                " The friend must wait until the delay period to vouch for this recovery"
              ]
            },
            {
              "name": "AlreadyVouched",
              "documentation": [" This user has already vouched for this recovery"]
            },
            {
              "name": "Threshold",
              "documentation": [" The threshold for recovering this account has not been met"]
            },
            {
              "name": "StillActive",
              "documentation": [" There are still active recovery attempts that need to be closed"]
            },
            {
              "name": "Overflow",
              "documentation": [" There was an overflow in a calculation"]
            },
            {
              "name": "AlreadyProxy",
              "documentation": [" This account is already set up for recovery"]
            }
          ],
          "index": 26
        },
        {
          "name": "Vesting",
          "storage": {
            "prefix": "Vesting",
            "items": [
              {
                "name": "Vesting",
                "modifier": "Optional",
                "type": {
                  "Map": {
                    "hasher": "Blake2_128Concat",
                    "key": "AccountId",
                    "value": "VestingInfo",
                    "linked": false
                  }
                },
                "fallback": "0x00",
                "documentation": [" Information regarding the vesting of a given account."]
              }
            ]
          },
          "calls": [
            {
              "name": "vest",
              "args": [],
              "documentation": [
                " Unlock any vested funds of the sender account.",
                "",
                " The dispatch origin for this call must be _Signed_ and the sender must have funds still",
                " locked under this module.",
                "",
                " Emits either `VestingCompleted` or `VestingUpdated`.",
                "",
                " # <weight>",
                " - `O(1)`.",
                " - DbWeight: 2 Reads, 2 Writes",
                "     - Reads: Vesting Storage, Balances Locks, [Sender Account]",
                "     - Writes: Vesting Storage, Balances Locks, [Sender Account]",
                " # </weight>"
              ]
            },
            {
              "name": "vest_other",
              "args": [
                {"name": "target", "type": "LookupSource"}
              ],
              "documentation": [
                " Unlock any vested funds of a `target` account.",
                "",
                " The dispatch origin for this call must be _Signed_.",
                "",
                " - `target`: The account whose vested funds should be unlocked. Must have funds still",
                " locked under this module.",
                "",
                " Emits either `VestingCompleted` or `VestingUpdated`.",
                "",
                " # <weight>",
                " - `O(1)`.",
                " - DbWeight: 3 Reads, 3 Writes",
                "     - Reads: Vesting Storage, Balances Locks, Target Account",
                "     - Writes: Vesting Storage, Balances Locks, Target Account",
                " # </weight>"
              ]
            },
            {
              "name": "vested_transfer",
              "args": [
                {"name": "target", "type": "LookupSource"},
                {"name": "schedule", "type": "VestingInfo"}
              ],
              "documentation": [
                " Create a vested transfer.",
                "",
                " The dispatch origin for this call must be _Signed_.",
                "",
                " - `target`: The account that should be transferred the vested funds.",
                " - `amount`: The amount of funds to transfer and will be vested.",
                " - `schedule`: The vesting schedule attached to the transfer.",
                "",
                " Emits `VestingCreated`.",
                "",
                " # <weight>",
                " - `O(1)`.",
                " - DbWeight: 3 Reads, 3 Writes",
                "     - Reads: Vesting Storage, Balances Locks, Target Account, [Sender Account]",
                "     - Writes: Vesting Storage, Balances Locks, Target Account, [Sender Account]",
                " # </weight>"
              ]
            },
            {
              "name": "force_vested_transfer",
              "args": [
                {"name": "source", "type": "LookupSource"},
                {"name": "target", "type": "LookupSource"},
                {"name": "schedule", "type": "VestingInfo"}
              ],
              "documentation": [
                " Force a vested transfer.",
                "",
                " The dispatch origin for this call must be _Root_.",
                "",
                " - `source`: The account whose funds should be transferred.",
                " - `target`: The account that should be transferred the vested funds.",
                " - `amount`: The amount of funds to transfer and will be vested.",
                " - `schedule`: The vesting schedule attached to the transfer.",
                "",
                " Emits `VestingCreated`.",
                "",
                " # <weight>",
                " - `O(1)`.",
                " - DbWeight: 4 Reads, 4 Writes",
                "     - Reads: Vesting Storage, Balances Locks, Target Account, Source Account",
                "     - Writes: Vesting Storage, Balances Locks, Target Account, Source Account",
                " # </weight>"
              ]
            }
          ],
          "events": [
            {
              "name": "VestingUpdated",
              "args": ["AccountId", "Balance"],
              "documentation": [
                " The amount vested has been updated. This could indicate more funds are available. The",
                " balance given is the amount which is left unvested (and thus locked).",
                " \\[account, unvested\\]"
              ]
            },
            {
              "name": "VestingCompleted",
              "args": ["AccountId"],
              "documentation": [
                " An \\[account\\] has become fully vested. No further vesting can happen."
              ]
            }
          ],
          "constants": [
            {
              "name": "MinVestedTransfer",
              "type": "BalanceOf",
              "value": "0x0000c16ff28623000000000000000000",
              "documentation": [
                " The minimum amount to be transferred to create a new vesting schedule."
              ]
            }
          ],
          "errors": [
            {
              "name": "NotVesting",
              "documentation": [" The account given is not vesting."]
            },
            {
              "name": "ExistingVestingSchedule",
              "documentation": [
                " An existing vesting schedule already exists for this account that cannot be clobbered."
              ]
            },
            {
              "name": "AmountLow",
              "documentation": [
                " Amount being transferred is too low to create a vesting schedule."
              ]
            }
          ],
          "index": 27
        },
        {
          "name": "Scheduler",
          "storage": {
            "prefix": "Scheduler",
            "items": [
              {
                "name": "Agenda",
                "modifier": "Default",
                "type": {
                  "Map": {
                    "hasher": "Twox64Concat",
                    "key": "BlockNumber",
                    "value": "Vec<Option<Scheduled>>",
                    "linked": false
                  }
                },
                "fallback": "0x00",
                "documentation": [
                  " Items to be executed, indexed by the block number that they should be executed on."
                ]
              },
              {
                "name": "Lookup",
                "modifier": "Optional",
                "type": {
                  "Map": {
                    "hasher": "Twox64Concat",
                    "key": "Bytes",
                    "value": "TaskAddress",
                    "linked": false
                  }
                },
                "fallback": "0x00",
                "documentation": [
                  " Lookup from identity to the block number and index of the task."
                ]
              },
              {
                "name": "StorageVersion",
                "modifier": "Default",
                "type": {"Plain": "Releases"},
                "fallback": "0x00",
                "documentation": [
                  " Storage version of the pallet.",
                  "",
                  " New networks start with last version."
                ]
              }
            ]
          },
          "calls": [
            {
              "name": "schedule",
              "args": [
                {"name": "when", "type": "BlockNumber"},
                {"name": "maybe_periodic", "type": "Option<Period>"},
                {"name": "priority", "type": "Priority"},
                {"name": "call", "type": "Call"}
              ],
              "documentation": [
                " Anonymously schedule a task.",
                "",
                " # <weight>",
                " - S = Number of already scheduled calls",
                " - Base Weight: 22.29 + .126 * S µs",
                " - DB Weight:",
                "     - Read: Agenda",
                "     - Write: Agenda",
                " - Will use base weight of 25 which should be good for up to 30 scheduled calls",
                " # </weight>"
              ]
            },
            {
              "name": "cancel",
              "args": [
                {"name": "when", "type": "BlockNumber"},
                {"name": "index", "type": "u32"}
              ],
              "documentation": [
                " Cancel an anonymously scheduled task.",
                "",
                " # <weight>",
                " - S = Number of already scheduled calls",
                " - Base Weight: 22.15 + 2.869 * S µs",
                " - DB Weight:",
                "     - Read: Agenda",
                "     - Write: Agenda, Lookup",
                " - Will use base weight of 100 which should be good for up to 30 scheduled calls",
                " # </weight>"
              ]
            },
            {
              "name": "schedule_named",
              "args": [
                {"name": "id", "type": "Bytes"},
                {"name": "when", "type": "BlockNumber"},
                {"name": "maybe_periodic", "type": "Option<Period>"},
                {"name": "priority", "type": "Priority"},
                {"name": "call", "type": "Call"}
              ],
              "documentation": [
                " Schedule a named task.",
                "",
                " # <weight>",
                " - S = Number of already scheduled calls",
                " - Base Weight: 29.6 + .159 * S µs",
                " - DB Weight:",
                "     - Read: Agenda, Lookup",
                "     - Write: Agenda, Lookup",
                " - Will use base weight of 35 which should be good for more than 30 scheduled calls",
                " # </weight>"
              ]
            },
            {
              "name": "cancel_named",
              "args": [
                {"name": "id", "type": "Bytes"}
              ],
              "documentation": [
                " Cancel a named scheduled task.",
                "",
                " # <weight>",
                " - S = Number of already scheduled calls",
                " - Base Weight: 24.91 + 2.907 * S µs",
                " - DB Weight:",
                "     - Read: Agenda, Lookup",
                "     - Write: Agenda, Lookup",
                " - Will use base weight of 100 which should be good for up to 30 scheduled calls",
                " # </weight>"
              ]
            },
            {
              "name": "schedule_after",
              "args": [
                {"name": "after", "type": "BlockNumber"},
                {"name": "maybe_periodic", "type": "Option<Period>"},
                {"name": "priority", "type": "Priority"},
                {"name": "call", "type": "Call"}
              ],
              "documentation": [
                " Anonymously schedule a task after a delay.",
                "",
                " # <weight>",
                " Same as [`schedule`].",
                " # </weight>"
              ]
            },
            {
              "name": "schedule_named_after",
              "args": [
                {"name": "id", "type": "Bytes"},
                {"name": "after", "type": "BlockNumber"},
                {"name": "maybe_periodic", "type": "Option<Period>"},
                {"name": "priority", "type": "Priority"},
                {"name": "call", "type": "Call"}
              ],
              "documentation": [
                " Schedule a named task after a delay.",
                "",
                " # <weight>",
                " Same as [`schedule_named`].",
                " # </weight>"
              ]
            }
          ],
          "events": [
            {
              "name": "Scheduled",
              "args": ["BlockNumber", "u32"],
              "documentation": [" Scheduled some task. \\[when, index\\]"]
            },
            {
              "name": "Canceled",
              "args": ["BlockNumber", "u32"],
              "documentation": [" Canceled some task. \\[when, index\\]"]
            },
            {
              "name": "Dispatched",
              "args": ["TaskAddress", "Option<Bytes>", "DispatchResult"],
              "documentation": [" Dispatched some task. \\[task, id, result\\]"]
            }
          ],
          "constants": [],
          "errors": [
            {
              "name": "FailedToSchedule",
              "documentation": [" Failed to schedule a call"]
            },
            {
              "name": "NotFound",
              "documentation": [" Cannot find the scheduled call."]
            },
            {
              "name": "TargetBlockNumberInPast",
              "documentation": [" Given target block number is in the past."]
            },
            {
              "name": "RescheduleNoChange",
              "documentation": [" Reschedule failed because it does not change scheduled time."]
            }
          ],
          "index": 28
        },
        {
          "name": "Proxy",
          "storage": {
            "prefix": "Proxy",
            "items": [
              {
                "name": "Proxies",
                "modifier": "Default",
                "type": {
                  "Map": {
                    "hasher": "Twox64Concat",
                    "key": "AccountId",
                    "value": "(Vec<ProxyDefinition>,BalanceOf)",
                    "linked": false
                  }
                },
                "fallback": "0x0000000000000000000000000000000000",
                "documentation": [
                  " The set of account proxies. Maps the account which has delegated to the accounts",
                  " which are being delegated to, together with the amount held on deposit."
                ]
              },
              {
                "name": "Announcements",
                "modifier": "Default",
                "type": {
                  "Map": {
                    "hasher": "Twox64Concat",
                    "key": "AccountId",
                    "value": "(Vec<ProxyAnnouncement>,BalanceOf)",
                    "linked": false
                  }
                },
                "fallback": "0x0000000000000000000000000000000000",
                "documentation": [" The announcements made by the proxy (key)."]
              }
            ]
          },
          "calls": [
            {
              "name": "proxy",
              "args": [
                {"name": "real", "type": "AccountId"},
                {"name": "force_proxy_type", "type": "Option<ProxyType>"},
                {"name": "call", "type": "Call"}
              ],
              "documentation": [
                " Dispatch the given `call` from an account that the sender is authorised for through",
                " `add_proxy`.",
                "",
                " Removes any corresponding announcement(s).",
                "",
                " The dispatch origin for this call must be _Signed_.",
                "",
                " Parameters:",
                " - `real`: The account that the proxy will make a call on behalf of.",
                " - `force_proxy_type`: Specify the exact proxy type to be used and checked for this call.",
                " - `call`: The call to be made by the `real` account.",
                "",
                " # <weight>",
                " Weight is a function of the number of proxies the user has (P).",
                " # </weight>"
              ]
            },
            {
              "name": "add_proxy",
              "args": [
                {"name": "delegate", "type": "AccountId"},
                {"name": "proxy_type", "type": "ProxyType"},
                {"name": "delay", "type": "BlockNumber"}
              ],
              "documentation": [
                " Register a proxy account for the sender that is able to make calls on its behalf.",
                "",
                " The dispatch origin for this call must be _Signed_.",
                "",
                " Parameters:",
                " - `proxy`: The account that the `caller` would like to make a proxy.",
                " - `proxy_type`: The permissions allowed for this proxy account.",
                " - `delay`: The announcement period required of the initial proxy. Will generally be",
                " zero.",
                "",
                " # <weight>",
                " Weight is a function of the number of proxies the user has (P).",
                " # </weight>"
              ]
            },
            {
              "name": "remove_proxy",
              "args": [
                {"name": "delegate", "type": "AccountId"},
                {"name": "proxy_type", "type": "ProxyType"},
                {"name": "delay", "type": "BlockNumber"}
              ],
              "documentation": [
                " Unregister a proxy account for the sender.",
                "",
                " The dispatch origin for this call must be _Signed_.",
                "",
                " Parameters:",
                " - `proxy`: The account that the `caller` would like to remove as a proxy.",
                " - `proxy_type`: The permissions currently enabled for the removed proxy account.",
                "",
                " # <weight>",
                " Weight is a function of the number of proxies the user has (P).",
                " # </weight>"
              ]
            },
            {
              "name": "remove_proxies",
              "args": [],
              "documentation": [
                " Unregister all proxy accounts for the sender.",
                "",
                " The dispatch origin for this call must be _Signed_.",
                "",
                " WARNING: This may be called on accounts created by `anonymous`, however if done, then",
                " the unreserved fees will be inaccessible. **All access to this account will be lost.**",
                "",
                " # <weight>",
                " Weight is a function of the number of proxies the user has (P).",
                " # </weight>"
              ]
            },
            {
              "name": "anonymous",
              "args": [
                {"name": "proxy_type", "type": "ProxyType"},
                {"name": "delay", "type": "BlockNumber"},
                {"name": "index", "type": "u16"}
              ],
              "documentation": [
                " Spawn a fresh new account that is guaranteed to be otherwise inaccessible, and",
                " initialize it with a proxy of `proxy_type` for `origin` sender.",
                "",
                " Requires a `Signed` origin.",
                "",
                " - `proxy_type`: The type of the proxy that the sender will be registered as over the",
                " new account. This will almost always be the most permissive `ProxyType` possible to",
                " allow for maximum flexibility.",
                " - `index`: A disambiguation index, in case this is called multiple times in the same",
                " transaction (e.g. with `utility::batch`). Unless you're using `batch` you probably just",
                " want to use `0`.",
                " - `delay`: The announcement period required of the initial proxy. Will generally be",
                " zero.",
                "",
                " Fails with `Duplicate` if this has already been called in this transaction, from the",
                " same sender, with the same parameters.",
                "",
                " Fails if there are insufficient funds to pay for deposit.",
                "",
                " # <weight>",
                " Weight is a function of the number of proxies the user has (P).",
                " # </weight>",
                " TODO: Might be over counting 1 read"
              ]
            },
            {
              "name": "kill_anonymous",
              "args": [
                {"name": "spawner", "type": "AccountId"},
                {"name": "proxy_type", "type": "ProxyType"},
                {"name": "index", "type": "u16"},
                {"name": "height", "type": "Compact<BlockNumber>"},
                {"name": "ext_index", "type": "Compact<u32>"}
              ],
              "documentation": [
                " Removes a previously spawned anonymous proxy.",
                "",
                " WARNING: **All access to this account will be lost.** Any funds held in it will be",
                " inaccessible.",
                "",
                " Requires a `Signed` origin, and the sender account must have been created by a call to",
                " `anonymous` with corresponding parameters.",
                "",
                " - `spawner`: The account that originally called `anonymous` to create this account.",
                " - `index`: The disambiguation index originally passed to `anonymous`. Probably `0`.",
                " - `proxy_type`: The proxy type originally passed to `anonymous`.",
                " - `height`: The height of the chain when the call to `anonymous` was processed.",
                " - `ext_index`: The extrinsic index in which the call to `anonymous` was processed.",
                "",
                " Fails with `NoPermission` in case the caller is not a previously created anonymous",
                " account whose `anonymous` call has corresponding parameters.",
                "",
                " # <weight>",
                " Weight is a function of the number of proxies the user has (P).",
                " # </weight>"
              ]
            },
            {
              "name": "announce",
              "args": [
                {"name": "real", "type": "AccountId"},
                {"name": "call_hash", "type": "CallHashOf"}
              ],
              "documentation": [
                " Publish the hash of a proxy-call that will be made in the future.",
                "",
                " This must be called some number of blocks before the corresponding `proxy` is attempted",
                " if the delay associated with the proxy relationship is greater than zero.",
                "",
                " No more than `MaxPending` announcements may be made at any one time.",
                "",
                " This will take a deposit of `AnnouncementDepositFactor` as well as",
                " `AnnouncementDepositBase` if there are no other pending announcements.",
                "",
                " The dispatch origin for this call must be _Signed_ and a proxy of `real`.",
                "",
                " Parameters:",
                " - `real`: The account that the proxy will make a call on behalf of.",
                " - `call_hash`: The hash of the call to be made by the `real` account.",
                "",
                " # <weight>",
                " Weight is a function of:",
                " - A: the number of announcements made.",
                " - P: the number of proxies the user has.",
                " # </weight>"
              ]
            },
            {
              "name": "remove_announcement",
              "args": [
                {"name": "real", "type": "AccountId"},
                {"name": "call_hash", "type": "CallHashOf"}
              ],
              "documentation": [
                " Remove a given announcement.",
                "",
                " May be called by a proxy account to remove a call they previously announced and return",
                " the deposit.",
                "",
                " The dispatch origin for this call must be _Signed_.",
                "",
                " Parameters:",
                " - `real`: The account that the proxy will make a call on behalf of.",
                " - `call_hash`: The hash of the call to be made by the `real` account.",
                "",
                " # <weight>",
                " Weight is a function of:",
                " - A: the number of announcements made.",
                " - P: the number of proxies the user has.",
                " # </weight>"
              ]
            },
            {
              "name": "reject_announcement",
              "args": [
                {"name": "delegate", "type": "AccountId"},
                {"name": "call_hash", "type": "CallHashOf"}
              ],
              "documentation": [
                " Remove the given announcement of a delegate.",
                "",
                " May be called by a target (proxied) account to remove a call that one of their delegates",
                " (`delegate`) has announced they want to execute. The deposit is returned.",
                "",
                " The dispatch origin for this call must be _Signed_.",
                "",
                " Parameters:",
                " - `delegate`: The account that previously announced the call.",
                " - `call_hash`: The hash of the call to be made.",
                "",
                " # <weight>",
                " Weight is a function of:",
                " - A: the number of announcements made.",
                " - P: the number of proxies the user has.",
                " # </weight>"
              ]
            },
            {
              "name": "proxy_announced",
              "args": [
                {"name": "delegate", "type": "AccountId"},
                {"name": "real", "type": "AccountId"},
                {"name": "force_proxy_type", "type": "Option<ProxyType>"},
                {"name": "call", "type": "Call"}
              ],
              "documentation": [
                " Dispatch the given `call` from an account that the sender is authorised for through",
                " `add_proxy`.",
                "",
                " Removes any corresponding announcement(s).",
                "",
                " The dispatch origin for this call must be _Signed_.",
                "",
                " Parameters:",
                " - `real`: The account that the proxy will make a call on behalf of.",
                " - `force_proxy_type`: Specify the exact proxy type to be used and checked for this call.",
                " - `call`: The call to be made by the `real` account.",
                "",
                " # <weight>",
                " Weight is a function of:",
                " - A: the number of announcements made.",
                " - P: the number of proxies the user has.",
                " # </weight>"
              ]
            }
          ],
          "events": [
            {
              "name": "ProxyExecuted",
              "args": ["DispatchResult"],
              "documentation": [" A proxy was executed correctly, with the given \\[result\\]."]
            },
            {
              "name": "AnonymousCreated",
              "args": ["AccountId", "AccountId", "ProxyType", "u16"],
              "documentation": [
                " Anonymous account has been created by new proxy with given",
                " disambiguation index and proxy type. \\[anonymous, who, proxy_type, disambiguation_index\\]"
              ]
            },
            {
              "name": "Announced",
              "args": ["AccountId", "AccountId", "Hash"],
              "documentation": [
                " An announcement was placed to make a call in the future. \\[real, proxy, call_hash\\]"
              ]
            }
          ],
          "constants": [
            {
              "name": "ProxyDepositBase",
              "type": "BalanceOf",
              "value": "0x00f09e544c3900000000000000000000",
              "documentation": [
                " The base amount of currency needed to reserve for creating a proxy."
              ]
            },
            {
              "name": "ProxyDepositFactor",
              "type": "BalanceOf",
              "value": "0x0060aa7714b400000000000000000000",
              "documentation": [" The amount of currency needed per proxy added."]
            },
            {
              "name": "MaxProxies",
              "type": "u16",
              "value": "0x2000",
              "documentation": [" The maximum amount of proxies allowed for a single account."]
            },
            {
              "name": "MaxPending",
              "type": "u32",
              "value": "0x20000000",
              "documentation": [" `MaxPending` metadata shadow."]
            },
            {
              "name": "AnnouncementDepositBase",
              "type": "BalanceOf",
              "value": "0x00f09e544c3900000000000000000000",
              "documentation": [" `AnnouncementDepositBase` metadata shadow."]
            },
            {
              "name": "AnnouncementDepositFactor",
              "type": "BalanceOf",
              "value": "0x00c054ef286801000000000000000000",
              "documentation": [" `AnnouncementDepositFactor` metadata shadow."]
            }
          ],
          "errors": [
            {
              "name": "TooMany",
              "documentation": [
                " There are too many proxies registered or too many announcements pending."
              ]
            },
            {
              "name": "NotFound",
              "documentation": [" Proxy registration not found."]
            },
            {
              "name": "NotProxy",
              "documentation": [" Sender is not a proxy of the account to be proxied."]
            },
            {
              "name": "Unproxyable",
              "documentation": [
                " A call which is incompatible with the proxy type's filter was attempted."
              ]
            },
            {
              "name": "Duplicate",
              "documentation": [" Account is already a proxy."]
            },
            {
              "name": "NoPermission",
              "documentation": [
                " Call may not be made by proxy because it may escalate its privileges."
              ]
            },
            {
              "name": "Unannounced",
              "documentation": [" Announcement, if made at all, was made too recently."]
            }
          ],
          "index": 29
        },
        {
          "name": "Multisig",
          "storage": {
            "prefix": "Multisig",
            "items": [
              {
                "name": "Multisigs",
                "modifier": "Optional",
                "type": {
                  "DoubleMap": {
                    "hasher": "Twox64Concat",
                    "key1": "AccountId",
                    "key2": "[u8;32]",
                    "value": "Multisig",
                    "key2Hasher": "Blake2_128Concat"
                  }
                },
                "fallback": "0x00",
                "documentation": [" The set of open multisig operations."]
              },
              {
                "name": "Calls",
                "modifier": "Optional",
                "type": {
                  "Map": {
                    "hasher": "Identity",
                    "key": "[u8;32]",
                    "value": "(OpaqueCall,AccountId,BalanceOf)",
                    "linked": false
                  }
                },
                "fallback": "0x00",
                "documentation": []
              }
            ]
          },
          "calls": [
            {
              "name": "as_multi_threshold_1",
              "args": [
                {"name": "other_signatories", "type": "Vec<AccountId>"},
                {"name": "call", "type": "Call"}
              ],
              "documentation": [
                " Immediately dispatch a multi-signature call using a single approval from the caller.",
                "",
                " The dispatch origin for this call must be _Signed_.",
                "",
                " - `other_signatories`: The accounts (other than the sender) who are part of the",
                " multi-signature, but do not participate in the approval process.",
                " - `call`: The call to be executed.",
                "",
                " Result is equivalent to the dispatched result.",
                "",
                " # <weight>",
                " O(Z + C) where Z is the length of the call and C its execution weight.",
                " -------------------------------",
                " - DB Weight: None",
                " - Plus Call Weight",
                " # </weight>"
              ]
            },
            {
              "name": "as_multi",
              "args": [
                {"name": "threshold", "type": "u16"},
                {"name": "other_signatories", "type": "Vec<AccountId>"},
                {"name": "maybe_timepoint", "type": "Option<Timepoint>"},
                {"name": "call", "type": "OpaqueCall"},
                {"name": "store_call", "type": "bool"},
                {"name": "max_weight", "type": "Weight"}
              ],
              "documentation": [
                " Register approval for a dispatch to be made from a deterministic composite account if",
                " approved by a total of `threshold - 1` of `other_signatories`.",
                "",
                " If there are enough, then dispatch the call.",
                "",
                " Payment: `DepositBase` will be reserved if this is the first approval, plus",
                " `threshold` times `DepositFactor`. It is returned once this dispatch happens or",
                " is cancelled.",
                "",
                " The dispatch origin for this call must be _Signed_.",
                "",
                " - `threshold`: The total number of approvals for this dispatch before it is executed.",
                " - `other_signatories`: The accounts (other than the sender) who can approve this",
                " dispatch. May not be empty.",
                " - `maybe_timepoint`: If this is the first approval, then this must be `None`. If it is",
                " not the first approval, then it must be `Some`, with the timepoint (block number and",
                " transaction index) of the first approval transaction.",
                " - `call`: The call to be executed.",
                "",
                " NOTE: Unless this is the final approval, you will generally want to use",
                " `approve_as_multi` instead, since it only requires a hash of the call.",
                "",
                " Result is equivalent to the dispatched result if `threshold` is exactly `1`. Otherwise",
                " on success, result is `Ok` and the result from the interior call, if it was executed,",
                " may be found in the deposited `MultisigExecuted` event.",
                "",
                " # <weight>",
                " - `O(S + Z + Call)`.",
                " - Up to one balance-reserve or unreserve operation.",
                " - One passthrough operation, one insert, both `O(S)` where `S` is the number of",
                "   signatories. `S` is capped by `MaxSignatories`, with weight being proportional.",
                " - One call encode & hash, both of complexity `O(Z)` where `Z` is tx-len.",
                " - One encode & hash, both of complexity `O(S)`.",
                " - Up to one binary search and insert (`O(logS + S)`).",
                " - I/O: 1 read `O(S)`, up to 1 mutate `O(S)`. Up to one remove.",
                " - One event.",
                " - The weight of the `call`.",
                " - Storage: inserts one item, value size bounded by `MaxSignatories`, with a",
                "   deposit taken for its lifetime of",
                "   `DepositBase + threshold * DepositFactor`.",
                " -------------------------------",
                " - DB Weight:",
                "     - Reads: Multisig Storage, [Caller Account], Calls (if `store_call`)",
                "     - Writes: Multisig Storage, [Caller Account], Calls (if `store_call`)",
                " - Plus Call Weight",
                " # </weight>"
              ]
            },
            {
              "name": "approve_as_multi",
              "args": [
                {"name": "threshold", "type": "u16"},
                {"name": "other_signatories", "type": "Vec<AccountId>"},
                {"name": "maybe_timepoint", "type": "Option<Timepoint>"},
                {"name": "call_hash", "type": "[u8;32]"},
                {"name": "max_weight", "type": "Weight"}
              ],
              "documentation": [
                " Register approval for a dispatch to be made from a deterministic composite account if",
                " approved by a total of `threshold - 1` of `other_signatories`.",
                "",
                " Payment: `DepositBase` will be reserved if this is the first approval, plus",
                " `threshold` times `DepositFactor`. It is returned once this dispatch happens or",
                " is cancelled.",
                "",
                " The dispatch origin for this call must be _Signed_.",
                "",
                " - `threshold`: The total number of approvals for this dispatch before it is executed.",
                " - `other_signatories`: The accounts (other than the sender) who can approve this",
                " dispatch. May not be empty.",
                " - `maybe_timepoint`: If this is the first approval, then this must be `None`. If it is",
                " not the first approval, then it must be `Some`, with the timepoint (block number and",
                " transaction index) of the first approval transaction.",
                " - `call_hash`: The hash of the call to be executed.",
                "",
                " NOTE: If this is the final approval, you will want to use `as_multi` instead.",
                "",
                " # <weight>",
                " - `O(S)`.",
                " - Up to one balance-reserve or unreserve operation.",
                " - One passthrough operation, one insert, both `O(S)` where `S` is the number of",
                "   signatories. `S` is capped by `MaxSignatories`, with weight being proportional.",
                " - One encode & hash, both of complexity `O(S)`.",
                " - Up to one binary search and insert (`O(logS + S)`).",
                " - I/O: 1 read `O(S)`, up to 1 mutate `O(S)`. Up to one remove.",
                " - One event.",
                " - Storage: inserts one item, value size bounded by `MaxSignatories`, with a",
                "   deposit taken for its lifetime of",
                "   `DepositBase + threshold * DepositFactor`.",
                " ----------------------------------",
                " - DB Weight:",
                "     - Read: Multisig Storage, [Caller Account]",
                "     - Write: Multisig Storage, [Caller Account]",
                " # </weight>"
              ]
            },
            {
              "name": "cancel_as_multi",
              "args": [
                {"name": "threshold", "type": "u16"},
                {"name": "other_signatories", "type": "Vec<AccountId>"},
                {"name": "timepoint", "type": "Timepoint"},
                {"name": "call_hash", "type": "[u8;32]"}
              ],
              "documentation": [
                " Cancel a pre-existing, on-going multisig transaction. Any deposit reserved previously",
                " for this operation will be unreserved on success.",
                "",
                " The dispatch origin for this call must be _Signed_.",
                "",
                " - `threshold`: The total number of approvals for this dispatch before it is executed.",
                " - `other_signatories`: The accounts (other than the sender) who can approve this",
                " dispatch. May not be empty.",
                " - `timepoint`: The timepoint (block number and transaction index) of the first approval",
                " transaction for this dispatch.",
                " - `call_hash`: The hash of the call to be executed.",
                "",
                " # <weight>",
                " - `O(S)`.",
                " - Up to one balance-reserve or unreserve operation.",
                " - One passthrough operation, one insert, both `O(S)` where `S` is the number of",
                "   signatories. `S` is capped by `MaxSignatories`, with weight being proportional.",
                " - One encode & hash, both of complexity `O(S)`.",
                " - One event.",
                " - I/O: 1 read `O(S)`, one remove.",
                " - Storage: removes one item.",
                " ----------------------------------",
                " - DB Weight:",
                "     - Read: Multisig Storage, [Caller Account], Refund Account, Calls",
                "     - Write: Multisig Storage, [Caller Account], Refund Account, Calls",
                " # </weight>"
              ]
            }
          ],
          "events": [
            {
              "name": "NewMultisig",
              "args": ["AccountId", "AccountId", "CallHash"],
              "documentation": [
                " A new multisig operation has begun. \\[approving, multisig, call_hash\\]"
              ]
            },
            {
              "name": "MultisigApproval",
              "args": ["AccountId", "Timepoint", "AccountId", "CallHash"],
              "documentation": [
                " A multisig operation has been approved by someone.",
                " \\[approving, timepoint, multisig, call_hash\\]"
              ]
            },
            {
              "name": "MultisigExecuted",
              "args": ["AccountId", "Timepoint", "AccountId", "CallHash", "DispatchResult"],
              "documentation": [
                " A multisig operation has been executed. \\[approving, timepoint, multisig, call_hash\\]"
              ]
            },
            {
              "name": "MultisigCancelled",
              "args": ["AccountId", "Timepoint", "AccountId", "CallHash"],
              "documentation": [
                " A multisig operation has been cancelled. \\[cancelling, timepoint, multisig, call_hash\\]"
              ]
            }
          ],
          "constants": [
            {
              "name": "DepositBase",
              "type": "BalanceOf",
              "value": "0x00f01c0adbed01000000000000000000",
              "documentation": [
                " The base amount of currency needed to reserve for creating a multisig execution or to store",
                " a dispatch call for later."
              ]
            },
            {
              "name": "DepositFactor",
              "type": "BalanceOf",
              "value": "0x0000cc7b9fae00000000000000000000",
              "documentation": [
                " The amount of currency needed per unit threshold when creating a multisig execution."
              ]
            },
            {
              "name": "MaxSignatories",
              "type": "u16",
              "value": "0x6400",
              "documentation": [" The maximum amount of signatories allowed for a given multisig."]
            }
          ],
          "errors": [
            {
              "name": "MinimumThreshold",
              "documentation": [" Threshold must be 2 or greater."]
            },
            {
              "name": "AlreadyApproved",
              "documentation": [" Call is already approved by this signatory."]
            },
            {
              "name": "NoApprovalsNeeded",
              "documentation": [" Call doesn't need any (more) approvals."]
            },
            {
              "name": "TooFewSignatories",
              "documentation": [" There are too few signatories in the list."]
            },
            {
              "name": "TooManySignatories",
              "documentation": [" There are too many signatories in the list."]
            },
            {
              "name": "SignatoriesOutOfOrder",
              "documentation": [
                " The signatories were provided out of order; they should be ordered."
              ]
            },
            {
              "name": "SenderInSignatories",
              "documentation": [
                " The sender was contained in the other signatories; it shouldn't be."
              ]
            },
            {
              "name": "NotFound",
              "documentation": [" Multisig operation not found when attempting to cancel."]
            },
            {
              "name": "NotOwner",
              "documentation": [
                " Only the account that originally created the multisig is able to cancel it."
              ]
            },
            {
              "name": "NoTimepoint",
              "documentation": [
                " No timepoint was given, yet the multisig operation is already underway."
              ]
            },
            {
              "name": "WrongTimepoint",
              "documentation": [
                " A different timepoint was given to the multisig operation that is underway."
              ]
            },
            {
              "name": "UnexpectedTimepoint",
              "documentation": [" A timepoint was given, yet no multisig operation is underway."]
            },
            {
              "name": "WeightTooLow",
              "documentation": [" The maximum weight information provided was too low."]
            },
            {
              "name": "AlreadyStored",
              "documentation": [" The data to be stored is already stored."]
            }
          ],
          "index": 30
        }
      ],
      "extrinsic": {
        "version": 4,
        "signedExtensions": [
          "CheckSpecVersion",
          "CheckTxVersion",
          "CheckGenesis",
          "CheckMortality",
          "CheckNonce",
          "CheckWeight",
          "ChargeTransactionPayment"
        ]
      }
    }
  }
};
