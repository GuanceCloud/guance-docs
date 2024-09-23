package main

import (
	"github.com/stretchr/testify/assert"
	"gopkg.in/yaml.v2"

	T "testing"
)

func Test_mdYaml(t *T.T) {
	t.Run(`basic`, func(t *T.T) {
		y := mdYaml{
			Title:    "abc",
			Summary:  "abc summary",
			IconPath: "path/to/icon",
			Tags:     []string{"tag 1", "tag 2"},
			Dashboard: []dashboard{
				{},
			},
			Monitor: []monitor{{}},
		}

		x, err := yaml.Marshal(y)
		assert.NoError(t, err)

		t.Logf("x: \n%s", string(x))

		var y2 mdYaml
		assert.NoError(t, yaml.Unmarshal(x, &y2))

	})

	t.Run("unmarshal-space-after:", func(t *T.T) {
		x := []byte(`title: Aerospike # there shoule be space after :
summary: 'Collecting Aerospike-related metric information'
#__int_icon: icon/aerospike
dashboard:
  - Desc: 'Aerospike Namespace Overview Monitoring View'
    path: 'dashboard/zh/aerospike_namespace'
  - Desc: 'Aerospike Monitoring Stack Node Monitoring View'
    path: 'dashboard/zh/aerospike_stack_node'
monitor:
  - Desc: 'Aerospike Detection Library'
    path: 'monitor/zh/aerospike'`)

		var y mdYaml
		assert.NoError(t, yaml.Unmarshal(x, &y))
	})

}
