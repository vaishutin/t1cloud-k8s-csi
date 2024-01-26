package driver

import (
	"k8s.io/klog"
)

type T1Driver struct {
	nodeID   string
	endpoint string
}

func CreateDriver(nodeId string, endpoint string) (*T1Driver, error) {
	drv := &T1Driver{
		nodeID:   nodeId,
		endpoint: endpoint,
	}

	return drv, nil
}

func (drv *T1Driver) setup(nodeId string) error {
	klog.Infof("setup")

	return nil
}
