/**
 * Sample React Native App
 * https://github.com/facebook/react-native
 * @flow
 */

import React, { Component } from 'react';
import {
  AppRegistry,
  StyleSheet,
  Text,
  View,
  ScrollView,
  FlatList,
  Dimensions,
  TouchableOpacity,
  requireNativeComponent
} from 'react-native';
const {width: screenWidth, height: screenHeight} = Dimensions.get('window');

var Alalei = requireNativeComponent('AlaleiRefreshControl');
var Tangram = requireNativeComponent('TangramRefreshControl');

export default class demo extends Component {

  constructor(props) {
    super(props);
    this.state = {
      refreshing: false,
      refreshType: 0,
      lines: '喜欢一个人需要理由吗？'
    }
  }

  componentDidMount() {
    this._handleRefresh();
  }

  _handleRefresh = () => {
    this.setState({
      refreshing: true
    });

    setTimeout(() => {
      
      this.setState({
        refreshing: false,
        lines: this.state.lines === '需要吗？' ? '不需要吗？' : '需要吗？'
      });
    }, 1500);
  }

  renderRefreshControl() {
    const MyRefresh = this.state.refreshType === 0 ? Alalei : Tangram;
    return <MyRefresh 
            refreshing={this.state.refreshing}
            onRefresh={this._handleRefresh} />
  }

  render() {
    const linesColor = this.state.refreshType === 0 ? '#ffffff' : '#000000';
    return (
      <View>
        <ScrollView
          style={{top: 0, backgroundColor: 'rgba(1, 1, 1, 0.0)'}}
          refreshControl={this.renderRefreshControl()}
        >
          <View style={styles.contentView}>
            <Text style={{top: 100, fontSize: 24, color: linesColor}}>
              {this.state.lines}
            </Text>
          </View>
        </ScrollView>
        <View style={styles.selectedView}>
          <TouchableOpacity
          onPress={() => {
            this.setState({
              refreshType: 0
            });
          }}>
            <View backgroundColor={'#FF69B4'}>
            <Text style={{color: '#ffffff', fontSize: 20, margin: 10}}>阿拉蕾</Text>
            </View>
          </TouchableOpacity>
          <TouchableOpacity
          onPress={() => {
            this.setState({
              refreshType: 1
            });
          }}>
          <View backgroundColor={'#00CED1'}>
            <Text style={{color: '#ffffff', fontSize: 20, margin: 10}}>七巧板</Text>
          </View>
          </TouchableOpacity>
        </View>
      </View>
    );
  }
}

const styles = StyleSheet.create({
  contentView: {
    flex: 1,
    width: screenWidth,
    height: screenHeight,
    alignItems: 'center'
  },
  selectedView: {
    position: 'absolute',
    width: screenWidth,
    height: 100,
    bottom: 0,
    left: 0,
    flexDirection: 'row',
    justifyContent: 'space-around',
    backgroundColor: 'rgba(1, 1, 1, 0.0)'
  }
});

AppRegistry.registerComponent('demo', () => demo);
